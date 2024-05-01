//
//  NetworkModelMetaDataView.swift
//

import SwiftUI

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
                Text("Class labels count: \(metadata.classLabels.count)")
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
    @State private var searchText = ""
    private var sortedClassLabels: [NeuralNetworkClassLabel] {
        return searchText.isEmpty ? classLabels :
        classLabels.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if (sortedClassLabels.isEmpty) {
                    Text(Constants.NoClassLabelsFoundText)
                } else {
                    List(sortedClassLabels) { item in
                        Text(item.name)
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle(Constants.ClassLabelsTitle)
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}

extension AllClassLabelsView {
    private enum Constants {
        static let ClassLabelsTitle: LocalizedStringKey = "Class labels"
        static let NoClassLabelsFoundText: LocalizedStringKey = "No class labels found"
    }
}

#Preview("Metadata") {
    NetworkModelMetaDataView(metadata: NeuralNetworkMetadataModel(name: "TestModel", description: "TestModelDescription", classLabels: [NeuralNetworkClassLabel(name: "ClassLabel1"), NeuralNetworkClassLabel(name: "ClassLabel2")]))
}
