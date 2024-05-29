//
//  FoodDescriptionViewModel.swift
//

import SwiftUI

class FoodDescriptionViewModel: BaseViewModel {
    private let selectedImageName: String
    @Published var viewState = FoodDescriptionViewState()
    
    init(selectedImageName: String) {
        self.selectedImageName = selectedImageName
    }
    
    override func onFirstTimeAppear() {
        guard let selectedFoodObject = Utils.getFoodObject(for: selectedImageName),
              let productMetadata = Utils.getFoodMetadata(for: selectedFoodObject),
              let productImage = selectedFoodObject.getFoodImage() else {
            viewState.productMetadata = ProductMetadataModel(name: selectedImageName, calories: 0.0)
            return
        }
        viewState.productMetadata = productMetadata
        viewState.productImage = productImage
    }
}

extension FoodDescriptionViewModel {
    struct FoodDescriptionViewState {
        var productMetadata: ProductMetadataModel? = nil
        var productImage: UIImage? = nil
    }
}
