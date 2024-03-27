//
//  NeuralNetworkTypes.swift
//

import Foundation

enum NeuralNetworkType: String, CaseIterable, Identifiable, Equatable {
    var id: Self {self}
    case imageTest
    case InceptionV3
    case MobileNet
    case SqueezeNet
    case SeeFood
}
