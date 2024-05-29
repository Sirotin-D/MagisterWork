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
        fetchFoodNutritionFacts()
    }
    
    private func fetchFoodNutritionFacts() {
        viewState.isLoading = true
        Task(priority: .userInitiated) {
            guard let foodMetadata = !GlobalSettings.shared.isXcodePreview ?
                    await FoodService.fetchFoodNutrition(foodName: selectedImageName) :
                        FoodNutritionFactsModel.getMockData()
            else {
                viewState.isLoading = false
                return
            }
            
            await MainActor.run {
                guard let selectedFoodObject = FoodService.getFoodObject(for: selectedImageName),
                      let productImage = selectedFoodObject.getFoodImage() else {
                    self.viewState.isLoading = false
                    return
                }
                viewState.productImage = productImage
                viewState.productMetadata = ProductMetadataModel(
                    name: selectedImageName,
                    calories: foodMetadata.calories,
                    proteins: foodMetadata.protein_g,
                    fats: foodMetadata.fat_total_g,
                    carbohydrates: foodMetadata.carbohydrates_total_g
                )
                viewState.isLoading = false
            }
        }
    }
}

extension FoodDescriptionViewModel {
    struct FoodDescriptionViewState {
        var isLoading = false
        var productMetadata: ProductMetadataModel? = nil
        var productImage: UIImage? = nil
    }
}
