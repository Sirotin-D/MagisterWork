//
//  PredictionInteractor.swift
//

import SwiftUI

class PredictionInteractor {
    private var predictor = ImagePredictor.shared
    func predictImage(for photo: UIImage,
                      completionHandler: @escaping ImagePredictor.ImagePredictionHandler) throws {
        try predictor.makePredictions(for: photo, completionHandler: completionHandler)
    }
}
