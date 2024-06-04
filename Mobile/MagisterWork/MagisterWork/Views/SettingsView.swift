//
//  SettingsView.swift
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var viewModel = SettingsPresenter()
    var body: some View {
        NavigationStack {
            VStack {
                Text(Constants.selectNeuralNetworkTitle)
                    .font(.headline)
                Picker(Constants.selectNeuralNetworkTitle, selection: $viewModel.settingsViewState.selectedNeuralNetwork) {
                    ForEach(NeuralNetworkType.allCases) { neuralNetworkType in
                        Text(neuralNetworkType.rawValue.capitalized)
                    }
                }
                .onChange(of: viewModel.settingsViewState.selectedNeuralNetwork) { oldValue, newValue in
                    viewModel.neuralNetworkChanged(type: newValue)
                }
                
                if let metadata = viewModel.settingsViewState.selectedNetworkMetadata {
                    NetworkModelMetaDataView(metadata: metadata)
                } else {
                    ProgressView().tint(.blue)
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.onAppear()
            }
            .navigationTitle(Constants.title)
        }
    }
}

extension SettingsView {
    private enum Constants {
        static let title: LocalizedStringKey = "Settings"
        static let selectNeuralNetworkTitle: LocalizedStringKey = "Select neural network model"
    }
}

#Preview("SettingsView") {
    SettingsView()
}
