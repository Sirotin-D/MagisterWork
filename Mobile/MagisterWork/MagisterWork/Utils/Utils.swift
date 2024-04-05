//
//  Utils.swift
//

import CoreML

class Utils {
    static func getNetworkSpecification() -> NeuralNetworkMetadataModel {
        let currentNetworkType = GlobalSettings.shared.currentNetworkType
        let neuralNetworkModel = NeuralNetworkBuilder.build(type: currentNetworkType)
        let networkModelDescription = neuralNetworkModel.modelDescription
        let modelMetaData = networkModelDescription.metadata
        let modelName = currentNetworkType.rawValue
        var modelDescription = ""
        var modelClassLabels: [NeuralNetworkClassLabel] = []
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
}
