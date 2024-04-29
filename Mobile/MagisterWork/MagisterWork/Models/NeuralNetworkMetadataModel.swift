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
