//
//  NeuralNetworkTypes.swift
//

import Foundation

enum NeuralNetworkType: String, CaseIterable, Identifiable, Equatable {
    var id: Self {self}
    case AlexNet = "AlexNet"
    case DenseNet = "DenseNet"
    case MobileNet = "MobileNet"
}
