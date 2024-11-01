//
//  CameraManager.swift
//

import SwiftUI
import AVFoundation

class CameraManager: NSObject, ObservableObject {
    @Published var capturedImage: UIImage? = nil
    private let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.unn.cameraManagerQueue")
    private let kLogTag = "CameraManager"
    
    func configureCaptureSession() {
        sessionQueue.async { [weak self] in
            guard let self else {return}
            self.session.beginConfiguration()
            self.session.sessionPreset = .photo
            self.setupVideoInput()
            self.setupVideoOutput()
            self.session.commitConfiguration()
        }
    }
    
    func getCaptureSession() -> AVCaptureSession {
        session
    }
    
    func startCapturing() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            if !session.isRunning {
                session.startRunning()
            }
        }
    }
    
    func stopCapturing() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
    }
    
    //MARK: - Private methods
    
    private func setupVideoInput() {
        do {
            guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                Logger.shared.e(kLogTag, "Video device is unavailable.")
                session.commitConfiguration()
                return
            }
            
            let videoInput = try AVCaptureDeviceInput(device: camera)
            guard session.canAddInput(videoInput) else {
                Logger.shared.e(kLogTag, "Couldn't add video device input to the session.")
                session.commitConfiguration()
                return
            }
            session.addInput(videoInput)
        } catch {
            Logger.shared.e(kLogTag, "Couldn't create video device input: \(error)")
            session.commitConfiguration()
            return
        }
    }
    
    private func setupVideoOutput() {
        let videoOutput = AVCaptureVideoDataOutput()
        guard session.canAddOutput(videoOutput) else {
            Logger.shared.e(kLogTag, "Error adding videoOutput")
            session.commitConfiguration()
            return
        }
        session.addOutput(videoOutput)
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            Logger.shared.e(kLogTag, "Error creating pixel buffer")
            return
        }
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            Logger.shared.e(kLogTag, "Error creating cgImage")
            return
        }
        let uiImage = UIImage(cgImage: cgImage)
        DispatchQueue.main.async {
            self.capturedImage = uiImage
        }
    }
}
