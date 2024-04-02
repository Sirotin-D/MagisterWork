//
//  NeuralNetworkTypes.swift
//

import Foundation

enum NeuralNetworkType: String, CaseIterable, Identifiable, Equatable {
    var id: Self {self}
    case imageTest
    case InceptionV3
    case MobileNet
    case MobileNetV2
    case MobileNetV2FP16
    case MobileNetV2Int8LUT
    case SqueezeNet
    case SeeFood
    case Deit
}
