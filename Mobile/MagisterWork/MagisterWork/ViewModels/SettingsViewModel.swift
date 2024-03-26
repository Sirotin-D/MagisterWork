//
//  SettingsViewModel.swift
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var selectedNeuralNetwork: NeuralNetworkType = GlobalSettings.shared.currentNetworkType
    func neuralNetworkChanged(type: NeuralNetworkType) {
        GlobalSettings.shared.currentNetworkType = type
    }
}
