//
//  SettingsViewModel.swift
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var settingsViewState = SettingsViewState()
    func neuralNetworkChanged(type: NeuralNetworkType) {
        GlobalSettings.shared.currentNetworkType = type
    }
}

extension SettingsViewModel {
    public struct SettingsViewState {
        var selectedNeuralNetwork = GlobalSettings.shared.currentNetworkType
    }
}
