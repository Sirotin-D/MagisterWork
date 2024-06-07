//
//  VNClassificationObservation+confidenceString.swift
//

import Vision

extension VNClassificationObservation {
    /// Generates a string of the observation's confidence as a percentage.
    var confidencePercentage: Float {
        return (confidence * 100 * 10).rounded() / 10
    }
}
