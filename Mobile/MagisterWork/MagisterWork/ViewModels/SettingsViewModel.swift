//
//  SettingsViewModel.swift
//

import SwiftUI

class SettingsViewModel: BaseViewModel {
    @Published var settingsViewState = SettingsViewState()
    func neuralNetworkChanged(type: NeuralNetworkType) {
        GlobalSettings.shared.currentNetworkType = type
        updateNetworkMetadata()
    }
    
    override func onFirstTimeAppear() {
        super.onFirstTimeAppear()
        updateNetworkMetadata()
    }
    
    //MARK: - Private methods
    
    private func updateNetworkMetadata() {
        settingsViewState.isLoading = true
        settingsViewState.selectedNetworkMetadata = nil
        DispatchQueue.global(qos: .background).async {
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
