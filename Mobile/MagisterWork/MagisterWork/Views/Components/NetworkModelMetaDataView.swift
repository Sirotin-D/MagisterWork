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

#Preview {
    NetworkModelMetaDataView(metadata: NeuralNetworkMetadataModel.getMockData())
}
