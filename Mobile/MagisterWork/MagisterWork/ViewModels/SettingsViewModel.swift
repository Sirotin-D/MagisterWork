//
//  SettingsViewModel.swift
//

import SwiftUI

class SettingsViewModel: BaseViewModel {
    @Published var settingsViewState = SettingsViewState()
    private var updateNeuralNetworkDataTask = Task{}
    
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
        if !updateNeuralNetworkDataTask.isCancelled {
            updateNeuralNetworkDataTask.cancel()
        }
        
        settingsViewState.isLoading = true
        settingsViewState.selectedNetworkMetadata = nil
        updateNeuralNetworkDataTask = Task(priority: .userInitiated) {
            let modelMetadata = await Utils.getNetworkSpecification()
            await MainActor.run { [weak self] in
                guard let self = self else { return }
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
