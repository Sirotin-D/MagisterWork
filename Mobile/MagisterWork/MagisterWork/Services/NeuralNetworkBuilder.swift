//
//  NeuralNetworkBuilder.swift
//

import CoreML

class NeuralNetworkBuilder {
    static func build(type: NeuralNetworkType) -> MLModel {
        let modelName = type.rawValue
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "mlmodelc") else {
            fatalError("Can't found resource with name: \(modelName)")
        }
        guard let model = try? MLModel(contentsOf: modelURL) else {
            fatalError("Can't initialize Neural Network model for type: \(type)")
        }
        return model
    }
}
