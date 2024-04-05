//
//  SettingsViewModel.swift
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var settingsViewState = SettingsViewState()
    func neuralNetworkChanged(type: NeuralNetworkType) {
        GlobalSettings.shared.currentNetworkType = type
        UpdateNetworkMetadata()
    }
    
    func OnAppear() {
        UpdateNetworkMetadata()
    }
    
    private func UpdateNetworkMetadata() {
        let dispatchQueue = DispatchQueue(label: "com.unn.settings")
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
        var showNNDocumentation = false
        var selectedNetworkMetadata: NeuralNetworkMetadataModel? = nil
    }
}
