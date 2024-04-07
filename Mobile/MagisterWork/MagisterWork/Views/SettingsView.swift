//
//  SettingsView.swift
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var viewModel = SettingsViewModel()
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
                }
                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.OnAppear()
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

struct NetworkModelMetaDataView: View {
    let metadata: NeuralNetworkMetadataModel
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(Constants.ModelNameSubTitle).bold()
                    Text(metadata.name)
                    Spacer()
                }
                .padding(.bottom, Constants.SubTitlesBottomPadding)
                Text(Constants.ModelDescriptionSubTitle).bold()
                Text(metadata.description)
                    .padding(.bottom, Constants.SubTitlesBottomPadding)
                Text(Constants.ModelClassLabelsSubTitle).bold()
                NavigationLink {
                    AllClassLabelsView(classLabels: metadata.classLabels)
                        .toolbar(.hidden, for: .tabBar)
                } label: {
                    Text(Constants.SeeAllClassLabelsButtonTitle)
                }
            }
        }
    }
}

extension NetworkModelMetaDataView {
    private enum Constants {
        static let ModelNameSubTitle: LocalizedStringKey = "Name:"
        static let ModelDescriptionSubTitle: LocalizedStringKey = "Description:"
        static let ModelClassLabelsSubTitle: LocalizedStringKey = "Classification class labels:"
        static let SeeAllClassLabelsButtonTitle: LocalizedStringKey = "See all class labels"
        static let SubTitlesBottomPadding = CGFloat(10)
    }
}

struct AllClassLabelsView: View {
    let classLabels: [NeuralNetworkClassLabel]
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, content: {
                Text("Class labels count: \(classLabels.count)")
                    .padding(.horizontal)
                List(classLabels) { item in
                    Text(item.name)
                }
            })
            .navigationTitle(Constants.ClassLabelsTitle)
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}

extension AllClassLabelsView {
    private enum Constants {
        static let ClassLabelsTitle: LocalizedStringKey = "Class labels"
        static let ClassLabelsCountSubtitle = "Class labels count:"
    }
}

#Preview("SettingsView") {
    SettingsView()
}

#Preview("MetadataView") {
    NetworkModelMetaDataView(metadata: NeuralNetworkMetadataModel(name: "TestModel", description: "TestModelDescription", classLabels: [NeuralNetworkClassLabel(name: "ClassLabel1"), NeuralNetworkClassLabel(name: "ClassLabel2")]))
}
