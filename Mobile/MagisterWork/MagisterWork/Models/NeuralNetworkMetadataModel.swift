//
//  NeuralNetworkMetadataModel.swift
//

import Foundation

struct NeuralNetworkMetadataModel {
    let name: String
    let description: String
    let classLabels: [NeuralNetworkClassLabel]
}

struct NeuralNetworkClassLabel: Identifiable {
    let id = UUID()
    let name: String
}
