//
//  LiveCameraViewModel.swift
//

import SwiftUI
import AVFoundation
import Combine

class LiveCameraViewModel: BaseViewModel {
    @Published var liveCameraViewState = LiveCameraViewState()
    @ObservedObject private var cameraManager = CameraManager()
    private var cancelables = Set<AnyCancellable>()
    private let predictor = ImagePredictor()
    private let predictionsToShow = 2
    private let kLogTag = "LiveCameraViewModel"
    
    override func onFirstTimeAppear() {
        super.onFirstTimeAppear()
        liveCameraViewState.captureSesion = cameraManager.getCaptureSession()
        cameraManager.configureCaptureSession()
        subscribeToCaptureSession()
        cameraManager.startCapturing()
    }
    
    override func onAppear() {
        super.onAppear()
        subscribeToCaptureSession()
        cameraManager.startCapturing()
    }
    
    override func onDisappear() {
        super.onDisappear()
        unsubscribeFromCaptureSession()
        cameraManager.stopCapturing()
    }
    
    //MARK: - Private methods
    
    private func subscribeToCaptureSession() {
        cameraManager.$capturedImage.sink { [weak self] image in
            self?.imageCaptured(photo: image)
        }.store(in: &cancelables)
    }
    
    private func unsubscribeFromCaptureSession() {
        self.cancelables.first?.cancel()
    }
    
    private func imageCaptured(photo: UIImage?) {
        guard let photo = photo else { return }
        let startTime = CFAbsoluteTimeGetCurrent()
        do {
            try predictor.makePredictions(for: photo) { predictions in
                guard let predictions = predictions else {
                    Logger.shared.e(self.kLogTag, "No predictions. Check console log.")
                    return
                }
                
                self.liveCameraViewState.predictionsResult = predictions.prefix(self.predictionsToShow).map{ prediction in
                    Prediction(classification: prediction.classification, confidencePercentage: prediction.confidencePercentage)
                }
                let endTime = CFAbsoluteTimeGetCurrent() - startTime
                self.liveCameraViewState.timeElapsed = Utils.formatElapsedTime(endTime)
            }
        } catch {
            Logger.shared.e(kLogTag, "Vision was unable to make a prediction: \(error.localizedDescription)")
        }
    }
}

extension LiveCameraViewModel {
    public struct LiveCameraViewState {
        var predictionsResult: [Prediction]?
        var timeElapsed: String = ""
        var captureSesion: AVCaptureSession?
    }
}
