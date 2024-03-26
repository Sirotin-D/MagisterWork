//
//  CameraViewModel.swift
//

import SwiftUI

class CameraViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isPresenting = false
    @Published var predictionsResult: [Prediction]?
    @Published var timeElapsed: String = ""
    private var predictor = ImagePredictor()
    private let predictionsToShow = 2
    
    func imageSelected(for photo: UIImage) {
        isLoading = true
        timeElapsed = ""
        predictionsResult = nil
        let startTime = CFAbsoluteTimeGetCurrent()
        
        do {
            try predictor.makePredictions(for: photo) { predictions in
                guard let predictions = predictions else {
                    print("No predictions. Check console log.")
                    self.isLoading = false
                    return
                }
                
                self.predictionsResult = predictions.prefix(self.predictionsToShow).map{ prediction in
                    Prediction(classification: prediction.classification, confidencePercentage: prediction.confidencePercentage)
                }
                self.isLoading = false
                let endTime = CFAbsoluteTimeGetCurrent() - startTime
                self.timeElapsed = self.formatElapsedTime(endTime)
            }
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }
    
    private func formatElapsedTime(_ value: Double) -> String {
        return String(format: "%.2f", (value * 100).rounded(.toNearestOrEven) / 100)
    }
}
