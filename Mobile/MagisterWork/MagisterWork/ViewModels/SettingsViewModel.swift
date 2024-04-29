//
//  SettingsViewModel.swift
//

import SwiftUI

class SettingsViewModel: BaseViewModel {
    @Published var settingsViewState = SettingsViewState()
    private var updateNeuralNetworkDataTask = Task{}
    
    func neuralNetworkChanged(type: NeuralNetworkType) {
        GlobalSettings.shared.currentNetworkType = type
        updateNetworkData()
    }
    
    override func onFirstTimeAppear() {
        super.onFirstTimeAppear()
        updateNetworkData()
    }
    
    //MARK: - Private methods
    
    private func updateNetworkData() {
        if !updateNeuralNetworkDataTask.isCancelled {
            updateNeuralNetworkDataTask.cancel()
        }
        settingsViewState.isLoading = true
        settingsViewState.selectedNetworkMetadata = nil
        updateNeuralNetworkDataTask = Task(priority: .userInitiated) {
            ImagePredictor.shared.updateImageClassifier()
            let modelMetadata = await Utils.getCurrentNetworkMetadata()
            let sortedMetaData = NeuralNetworkMetadataModel(
                name: modelMetadata.name,
                description: modelMetadata.description,
                classLabels: modelMetadata.classLabels.sorted { $0.name.lowercased() < $1.name.lowercased() })
            await MainActor.run { [weak self] in
                guard let self = self else { return }
                self.settingsViewState.isLoading = false
                self.settingsViewState.selectedNetworkMetadata = sortedMetaData
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
