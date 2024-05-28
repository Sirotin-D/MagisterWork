//
//  NeuralNetworkMetadataModel.swift
//

import CoreML

struct NeuralNetworkMetadataModel {
    let name: String
    let description: String
    let classLabels: [NeuralNetworkClassLabel]
}

struct NeuralNetworkClassLabel: Identifiable {
    let id = UUID()
    let name: String
}

struct ImageClassifierDescription {
    let modelDescription: MLModelDescription
    let modelType: NeuralNetworkType
}

extension NeuralNetworkClassLabel {
    static func getMockClassLabels() -> [NeuralNetworkClassLabel] {
        [
            NeuralNetworkClassLabel(name: "apple_pie"),
            NeuralNetworkClassLabel(name: "baby_back_ribs"),
            NeuralNetworkClassLabel(name: "chicken_curry"),
            NeuralNetworkClassLabel(name: "miso_soup"),
            NeuralNetworkClassLabel(name: "sushi")
        ]
    }
}

extension NeuralNetworkMetadataModel {
    static func getMockData() -> NeuralNetworkMetadataModel {
        NeuralNetworkMetadataModel(
            name: "TestModel",
            description: "TestModelDescription",
            classLabels: NeuralNetworkClassLabel.getMockClassLabels()
        )
    }
}
