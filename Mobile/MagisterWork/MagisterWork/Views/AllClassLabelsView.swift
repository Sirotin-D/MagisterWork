//
//  AllClassLabelsView.swift
//

import SwiftUI

struct AllClassLabelsView: View {
    let classLabels: [NeuralNetworkClassLabel]
    @State private var searchText = ""
    private var sortedClassLabels: [NeuralNetworkClassLabel] {
        return searchText.isEmpty ? classLabels :
        classLabels.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    init(classLabels: [NeuralNetworkClassLabel]) {
        self.classLabels = classLabels.map{ classLabel in
            guard let foodObject = FoodService.getFoodObject(for: classLabel.name) else {
                return classLabel
            }
            return NeuralNetworkClassLabel(name: foodObject.getValue().localized)
        }.sorted { $0.name.lowercased() < $1.name.lowercased() }
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

#Preview {
    AllClassLabelsView(classLabels: NeuralNetworkClassLabel.getMockClassLabels())
}
