//
//  Utils.swift
//

import CoreML

class Utils {
    static func getCurrentNetworkMetadata() async -> NeuralNetworkMetadataModel {
        let imageClassifierDescription = ImagePredictor.shared.getCurrentClassififerDescription()
        let networkModelDescription = imageClassifierDescription.modelDescription
        let modelName = imageClassifierDescription.modelType.rawValue
        let modelMetaData = imageClassifierDescription.modelDescription.metadata
        var modelDescription = ""
        var modelClassLabels = [NeuralNetworkClassLabel]()
        let metaDataKey = MLModelMetadataKey.description
        if let description = modelMetaData[metaDataKey] as? String {
            modelDescription = description
        }
        if let classLabels = networkModelDescription.classLabels as? [String] {
            modelClassLabels = classLabels.map { classLabel in
                NeuralNetworkClassLabel(name: classLabel)
            }
        }
        return NeuralNetworkMetadataModel(name: modelName, description: modelDescription, classLabels: modelClassLabels)
    }
    
    static func formatElapsedTime(_ value: Double) -> String {
        return String(format: "%.2f", (value * 100).rounded(.toNearestOrEven) / 100)
    }
    
    static func formatPersentage(_ value: Float) -> String {
        return String(format: "%.1f", (value * 10).rounded() / 10)
    }
}
