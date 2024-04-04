//
//  SettingsView.swift
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var viewModel = SettingsViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Text(Constants.selectNeuralNetworkTitle)
                    .font(.headline)
                Picker(Constants.selectNNLocalizedKey, selection: $viewModel.settingsViewState.selectedNeuralNetwork) {
                    ForEach(NeuralNetworkType.allCases) { neuralNetworkType in
                        Text(neuralNetworkType.rawValue.capitalized)
                    }
                }
                .onChange(of: viewModel.settingsViewState.selectedNeuralNetwork) { oldValue, newValue in
                    viewModel.neuralNetworkChanged(type: newValue)
                }
            }
            .navigationTitle(Constants.title)
        }
    }
}

extension SettingsView {
    private enum Constants {
        static let title = "Настройки"
        static let selectNeuralNetworkTitle = "Выберете модель нейронной сети"
        static let selectNNLocalizedKey = "Выбрать модель нейронной сети"
    }
}

#Preview {
    SettingsView()
}
