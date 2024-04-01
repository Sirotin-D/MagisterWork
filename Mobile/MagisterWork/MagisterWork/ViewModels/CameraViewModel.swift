//
//  CameraViewModel.swift
//

import SwiftUI

class CameraViewModel: ObservableObject {
    @Published var cameraState = CameraViewState()
    private var predictor = ImagePredictor()
    private let predictionsToShow = 2
    
    func imageSelected(for photo: UIImage) {
        cameraState.isLoading = true
        cameraState.timeElapsed = ""
        cameraState.predictionsResult = nil
        let startTime = CFAbsoluteTimeGetCurrent()
        
        do {
            try predictor.makePredictions(for: photo) { predictions in
                guard let predictions = predictions else {
                    print("No predictions. Check console log.")
                    self.cameraState.isLoading = false
                    return
                }
                
                self.cameraState.predictionsResult = predictions.prefix(self.predictionsToShow).map{ prediction in
                    Prediction(classification: prediction.classification, confidencePercentage: prediction.confidencePercentage)
                }
                self.cameraState.isLoading = false
                let endTime = CFAbsoluteTimeGetCurrent() - startTime
                self.cameraState.timeElapsed = self.formatElapsedTime(endTime)
            }
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    func photoLibraryImagePickerClicked() {
        cameraState.isPresenting = true
        cameraState.imageSourceType = .photoLibrary
    }
    
    func cameraImagePickerClicked() {
        cameraState.isPresenting = true
        cameraState.imageSourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
        ? .camera : .photoLibrary
    }
    
    func liveImageClassificationClicked() {
        cameraState.isShowAlert = true
    }
    
    private func formatElapsedTime(_ value: Double) -> String {
        return String(format: "%.2f", (value * 100).rounded(.toNearestOrEven) / 100)
    }
}

extension CameraViewModel {
    public struct CameraViewState {
        var isLoading = false
        var isPresenting = false
        var predictionsResult: [Prediction]?
        var timeElapsed: String = ""
        var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
        var isShowAlert = false
    }
}
