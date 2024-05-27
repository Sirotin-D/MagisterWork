//
//  GlobalSettings.swift
//

import Foundation

class GlobalSettings {
    static let shared = GlobalSettings()
    var currentNetworkType: NeuralNetworkType = .AlexNet
}
