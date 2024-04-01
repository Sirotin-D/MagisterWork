//
//  NeuralNetworkBuilder.swift
//

import Foundation
import CoreML

class NeuralNetworkBuilder {
    static func build(type: NeuralNetworkType) -> MLModel {
        var model: MLModel?
        let configuration = MLModelConfiguration()
        switch type {
        case .imageTest:
            model = try? imagetest(configuration: configuration).model
        case .InceptionV3:
            model = try? InceptionV3(configuration: configuration).model
        case .MobileNet:
             model = try? MobileNet(configuration: configuration).model
        case .SqueezeNet:
            model = try? SqueezeNet(configuration: configuration).model
        case .SeeFood:
            model = try? SeeFood(configuration: configuration).model
        }
        guard let model = model else { fatalError("Can't initialize Neural Network model for type: \(type)")}
        return model
    }
}