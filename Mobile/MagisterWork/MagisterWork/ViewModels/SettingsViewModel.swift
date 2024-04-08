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
        if settingsViewState.selectedNetworkMetadata == nil &&
            !settingsViewState.isLoading {
            updateNetworkMetadata()
        }
    }
    
    //MARK: - Private methods
    
    private func updateNetworkMetadata() {
        settingsViewState.isLoading = true
        settingsViewState.selectedNetworkMetadata = nil
        let dispatchQueue = DispatchQueue(label: "com.magisterwork.settings")
        dispatchQueue.async {
            let modelMetadata = Utils.getNetworkSpecification()
            DispatchQueue.main.async {
                self.settingsViewState.isLoading = false
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
        var isLoading = false
    }
}
