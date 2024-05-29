//
//  GlobalSettings.swift
//

import Foundation

class GlobalSettings {
    static let shared = GlobalSettings()
    var currentNetworkType: NeuralNetworkType = .AlexNet
    var isXcodePreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
