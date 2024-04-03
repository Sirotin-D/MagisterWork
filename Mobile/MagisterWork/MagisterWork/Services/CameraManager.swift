//
//  CameraManager.swift
//

import SwiftUI
import AVFoundation

class CameraManager: NSObject, ObservableObject {
    @Published var capturedImage: UIImage? = nil
    private let session = AVCaptureSession()
    private var videoDeviceInput: AVCaptureDeviceInput?
    private let videoOutput = AVCaptureVideoDataOutput()
    private let sessionQueue = DispatchQueue(label: "com.unn.sessionQueue")
    
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
            let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            guard let camera else {
                print("CameraManager: Video device is unavailable.")
                session.commitConfiguration()
                return
            }
            
            let videoInput = try AVCaptureDeviceInput(device: camera)
            
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
                videoDeviceInput = videoInput
            } else {
                print("CameraManager: Couldn't add video device input to the session.")
                session.commitConfiguration()
                return
            }
        } catch {
            print("CameraManager: Couldn't create video device input: \(error)")
            session.commitConfiguration()
            return
        }
    }
    
    private func setupVideoOutput() {
        guard session.canAddOutput(videoOutput) else {
            print("error adding videoOutput")
            session.commitConfiguration()
            return
        }
        session.addOutput(videoOutput)
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        videoOutput.connection(with: .video)?.videoOrientation = .portrait
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("Error creating pixel buffer")
            return
        }
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            print("Error creating cgImage")
            return
        }
        let uiImage = UIImage(cgImage: cgImage)
        DispatchQueue.main.async {
            self.capturedImage = uiImage
        }
    }
}
