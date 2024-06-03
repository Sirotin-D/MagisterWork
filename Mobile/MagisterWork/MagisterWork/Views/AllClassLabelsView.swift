//
//  AllClassLabelsView.swift
//

import SwiftUI

struct AllClassLabelsView: View {
    @ObservedObject private var viewModel: AllClassLabelsViewModel
    @State private var searchText = ""
    private var sortedClassLabels: [NeuralNetworkClassLabelViewData] {
        return searchText.isEmpty ? viewModel.viewState.classLabels :
        viewModel.viewState.classLabels.filter { $0.localizedName.lowercased().contains(searchText.lowercased()) }
    }
    
    init(classLabels: [NeuralNetworkClassLabel]) {
        viewModel = AllClassLabelsViewModel(classLabels: classLabels)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if (sortedClassLabels.isEmpty) {
                    Text(Constants.NoClassLabelsFoundText)
                } else {
                    List(sortedClassLabels) { item in
                        Button(action: {
                            viewModel.onClassLabelClicked(for: item)
                        }, label: {
                            Text(item.localizedName)
                                .foregroundStyle(.black)
                        })
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle(Constants.ClassLabelsTitle)
            .toolbarTitleDisplayMode(.inlineLarge)
            .sheet(isPresented: $viewModel.viewState.openFoodDescription) {
                FoodDescriptionView(
                    foodName: viewModel.viewState.selectedFoodObject
                )
            }
        }
        .onAppear {
            viewModel.onAppear()
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
