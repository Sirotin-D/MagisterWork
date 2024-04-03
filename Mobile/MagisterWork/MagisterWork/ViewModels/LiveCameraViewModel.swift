//
//  LiveCameraViewModel.swift
//

import SwiftUI
import AVFoundation
import Combine

class LiveCameraViewModel: ObservableObject {
    @Published var liveCameraState = LiveCameraViewState()
    @ObservedObject private var cameraManager = CameraManager()
    private var cancelables = Set<AnyCancellable>()
    private let predictor = ImagePredictor()
    private let predictionsToShow = 2
    
    init() {
        liveCameraState.captureSesion = cameraManager.getCaptureSession()
        cameraManager.configureCaptureSession()
    }
    
    func onAppear() {
        subscribeToCaptureSession()
        cameraManager.startCapturing()
    }
    
    func onDisappear() {
        unsubscribeFromCaptureSession()
        cameraManager.stopCapturing()
    }
    
    private func subscribeToCaptureSession() {
        cameraManager.$capturedImage.sink { [weak self] image in
            self?.imageCaptured(photo: image)
        }.store(in: &cancelables)
    }
    
    private func unsubscribeFromCaptureSession() {
        self.cancelables.first?.cancel()
    }
    
    //MARK: - Private methods
    
    private func imageCaptured(photo: UIImage?) {
        guard let photo = photo else { return }
        let startTime = CFAbsoluteTimeGetCurrent()
        do {
            try predictor.makePredictions(for: photo) { predictions in
                guard let predictions = predictions else {
                    print("No predictions. Check console log.")
                    return
                }
                
                self.liveCameraState.predictionsResult = predictions.prefix(self.predictionsToShow).map{ prediction in
                    Prediction(classification: prediction.classification, confidencePercentage: prediction.confidencePercentage)
                }
                let endTime = CFAbsoluteTimeGetCurrent() - startTime
                self.liveCameraState.timeElapsed = self.formatElapsedTime(endTime)
            }
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }
    
    private func formatElapsedTime(_ value: Double) -> String {
        return String(format: "%.2f", (value * 100).rounded(.toNearestOrEven) / 100)
    }
}

extension LiveCameraViewModel {
    public struct LiveCameraViewState {
        var predictionsResult: [Prediction]?
        var timeElapsed: String = ""
        var captureSesion: AVCaptureSession?
    }
}
