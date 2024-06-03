//
//  AllClassLabelsViewModel.swift
//

import Foundation

class AllClassLabelsViewModel: BaseViewModel {
    private var classLabels: [NeuralNetworkClassLabel]
    @Published public var viewState = AllClassLabelsViewState()
    
    init(classLabels: [NeuralNetworkClassLabel]) {
        self.classLabels = classLabels
    }
    
    override func onFirstTimeAppear() {
        super.onFirstTimeAppear()
        viewState.classLabels = classLabels.map{ classLabel in
            guard let foodObject = FoodService.getFoodObject(for: classLabel.name) else {
                return NeuralNetworkClassLabelViewData(
                    name: classLabel.name,
                    localizedName: classLabel.name.localized
                )
            }
            let foodName = foodObject.getValue()
            
            return NeuralNetworkClassLabelViewData(
                name: foodName,
                localizedName: foodName.localized
            )
        }.sorted {
            $0.localizedName.lowercased() < $1.localizedName.lowercased()
        }
    }
    
    public func onClassLabelClicked(for selectedClassLabel: NeuralNetworkClassLabelViewData) {
        viewState.selectedFoodObject = selectedClassLabel.name
        viewState.openFoodDescription = true
    }
}

extension AllClassLabelsViewModel {
    struct AllClassLabelsViewState {
        var classLabels: [NeuralNetworkClassLabelViewData] = []
        var openFoodDescription: Bool = false
        var selectedFoodObject = ""
    }
}
