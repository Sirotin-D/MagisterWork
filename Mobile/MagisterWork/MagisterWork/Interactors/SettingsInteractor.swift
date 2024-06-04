//
//  SettingsInteractor.swift
//

import Foundation

class SettingsInteractor {
    private let imagePredictor = ImagePredictor.shared
    
    func getCurrentNetworkMetadata() async -> NeuralNetworkMetadataModel {
        await Utils.getCurrentNetworkMetadata()
    }
    
    func updateImageClassifier() {
        imagePredictor.updateImageClassifier()
    }
}
