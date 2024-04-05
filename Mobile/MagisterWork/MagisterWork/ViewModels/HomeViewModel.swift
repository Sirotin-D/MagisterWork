//
//  HomeViewModel.swift
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var homeViewState = HomeViewState()
    private var predictor = ImagePredictor()
    private let predictionsToShow = 2
    private let kLogTag = "HomeViewModel"
    
    func imageSelected(for photo: UIImage) {
        homeViewState.isLoading = true
        homeViewState.timeElapsed = ""
        homeViewState.predictionsResult = nil
        let startTime = CFAbsoluteTimeGetCurrent()
        
        do {
            try predictor.makePredictions(for: photo) { predictions in
                guard let predictions = predictions else {
                    Logger.shared.e(self.kLogTag, "No predictions. Check console log.")
                    self.homeViewState.isLoading = false
                    return
                }
                
                self.homeViewState.predictionsResult = predictions.prefix(self.predictionsToShow).map{ prediction in
                    Prediction(classification: prediction.classification, confidencePercentage: prediction.confidencePercentage)
                }
                self.homeViewState.isLoading = false
                let endTime = CFAbsoluteTimeGetCurrent() - startTime
                self.homeViewState.timeElapsed = self.formatElapsedTime(endTime)
            }
        } catch {
            Logger.shared.e(kLogTag, "Vision was unable to make a prediction: \(error.localizedDescription)")
        }
    }

    func photoLibraryImagePickerClicked() {
        homeViewState.isPresenting = true
        homeViewState.imageSourceType = .photoLibrary
    }
    
    func cameraImagePickerClicked() {
        homeViewState.isPresenting = true
        homeViewState.imageSourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
        ? .camera : .photoLibrary
    }
    
    func liveImageClassificationClicked() {
        homeViewState.isShowAlert = true
    }
    
    private func formatElapsedTime(_ value: Double) -> String {
        return String(format: "%.2f", (value * 100).rounded(.toNearestOrEven) / 100)
    }
}

extension HomeViewModel {
    public struct HomeViewState {
        var isLoading = false
        var isPresenting = false
        var predictionsResult: [Prediction]?
        var timeElapsed: String = ""
        var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
        var isShowAlert = false
    }
}
