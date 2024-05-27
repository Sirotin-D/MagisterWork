//
//  NeuralNetworkTypes.swift
//

import Foundation

enum NeuralNetworkType: String, CaseIterable, Identifiable, Equatable {
    var id: Self {self}
    case imageTest = "imagetest"
    case InceptionV3 = "InceptionV3"
    case Resnet = "Resnet50"
    case MobileNet = "MobileNet"
    case MobileNetV2 = "MobileNetV2"
    case MobileNetV2FP16 = "MobileNetV2FP16"
    case MobileNetV2Int8LUT = "MobileNetV2Int8LUT"
    case SqueezeNet = "SqueezeNet"
    case SeeFood = "SeeFood"
    case Deit = "DeiT-base384"
    case AlexNet = "AlexNet"
    case DenseNetFood101="DenseNetFood101"
}
