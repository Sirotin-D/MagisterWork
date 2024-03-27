//
//  Prediction.swift
//

import Foundation

/// Stores a classification name and confidence for an image classifier's prediction.
/// - Tag: Prediction
struct Prediction: Identifiable {
    let id = UUID()
    
    /// The name of the object or scene the image classifier recognizes in an image.
    let classification: String

    /// The image classifier's confidence as a percentage string.
    ///
    /// The prediction string doesn't include the % symbol in the string.
    let confidencePercentage: String
}
