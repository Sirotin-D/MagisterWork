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
    private let predictor = ImagePredictor.shared
    private let predictionsToShow = 2
    private var isImagePredictorBusy = false
    private let kLogTag = "LiveCameraViewModel"
    
    override func onFirstTimeAppear() {
        super.onFirstTimeAppear()
        liveCameraViewState.captureSesion = cameraManager.getCaptureSession()
        cameraManager.configureCaptureSession()
    }
    
    func activateButtonClicked() {
        if !liveCameraViewState.isStartSessionButtonActivated {
            subscribeToCaptureSession()
            cameraManager.startCapturing()
        } else {
            unsubscribeFromCaptureSession()
            cameraManager.stopCapturing()
        }
        liveCameraViewState.isStartSessionButtonActivated = !liveCameraViewState.isStartSessionButtonActivated
    }
    
    func foodLabelClicked(foodName: String) {
        if liveCameraViewState.isStartSessionButtonActivated { return }
        liveCameraViewState.selectedFoodName = foodName
        liveCameraViewState.isShowFoodDescription = true
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
        guard !isImagePredictorBusy else { return }
        isImagePredictorBusy = true
        let startTime = CFAbsoluteTimeGetCurrent()
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try self.predictor.makePredictions(for: photo) { [weak self] predictions in
                    guard let self = self else { return }
                    guard let predictions = predictions else {
                        Logger.shared.e(self.kLogTag, "No predictions. Check console log.")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.liveCameraViewState.predictionsResult = predictions.prefix(self.predictionsToShow).map{ prediction in
                            guard let foodObject = FoodService.getFoodObject(for: prediction.classification) else {
                                return prediction
                            }
                            return Prediction(classification: foodObject.getValue(), confidencePercentage: prediction.confidencePercentage)
                        }
                        let endTime = CFAbsoluteTimeGetCurrent() - startTime
                        self.liveCameraViewState.timeElapsed = Utils.formatElapsedTime(endTime)
                        self.isImagePredictorBusy = false
                    }
                }
            } catch {
                Logger.shared.e(self.kLogTag, "Vision was unable to make a prediction: \(error.localizedDescription)")
            }
        }
//        DispatchQueue.global(qos: .userInitiated).async {
//
//        }
    }
}

extension LiveCameraViewModel {
    public struct LiveCameraViewState {
        var predictionsResult: [Prediction]?
        var timeElapsed: String = ""
        var captureSesion: AVCaptureSession?
        var isShowFoodDescription = false
        var selectedFoodName: String? = nil
        var isStartSessionButtonActivated = false
        var activateButtonColor: Color {
            isStartSessionButtonActivated ? .red : .blue
        }
    }
}
