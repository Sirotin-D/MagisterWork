//
//  SettingsViewModel.swift
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var settingsViewState = SettingsViewState()
    func neuralNetworkChanged(type: NeuralNetworkType) {
        GlobalSettings.shared.currentNetworkType = type
        updateNetworkMetadata()
    }
    
    func onAppear() {
        if settingsViewState.selectedNetworkMetadata == nil {
            updateNetworkMetadata()
        }
    }
    
    private func updateNetworkMetadata() {
        settingsViewState.selectedNetworkMetadata = nil
        let dispatchQueue = DispatchQueue(label: "com.magisterwork.settings")
        dispatchQueue.async {
            let modelMetadata = Utils.getNetworkSpecification()
            DispatchQueue.main.async {
                self.settingsViewState.selectedNetworkMetadata = NeuralNetworkMetadataModel(
                    name: modelMetadata.name,
                    description: modelMetadata.description,
                    classLabels: modelMetadata.classLabels)
            }
        }
    }
}

extension SettingsViewModel {
    public struct SettingsViewState {
        var selectedNeuralNetwork = GlobalSettings.shared.currentNetworkType
        var selectedNetworkMetadata: NeuralNetworkMetadataModel? = nil
    }
}
