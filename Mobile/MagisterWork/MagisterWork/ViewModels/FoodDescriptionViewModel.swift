//
//  FoodDescriptionViewModel.swift
//

import SwiftUI

class FoodDescriptionViewModel: BaseViewModel {
    private let kLogTag = "FoodDescriptionViewModel"
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
            var foodMetadata: ProductMetadataModel?
            
            if let foodMetadataResult = await FoodService.fetchFoodNutrition(foodName: selectedImageName) {
                foodMetadata = ProductMetadataModel(
                    name: selectedImageName,
                    calories: foodMetadataResult.calories,
                    proteins: foodMetadataResult.protein_g,
                    fats: foodMetadataResult.fat_total_g,
                    carbohydrates: foodMetadataResult.carbohydrates_total_g
                )
            } else {
                foodMetadata = FoodService.getMockFoodNutrition(foodName: selectedImageName)
            }
            
            guard let foodMetadata = foodMetadata else {
                Logger.shared.e(kLogTag, "No matching result found while fetching food nutrition facts")
                await MainActor.run {
                    viewState.isLoading = false
                }
                return
            }
            
            guard let selectedFoodObject = FoodService.getFoodObject(for: selectedImageName) else {
                await MainActor.run {
                    self.viewState.isLoading = false
                }
                return
            }
            
            await MainActor.run {
                viewState.productImage = selectedFoodObject.getFoodImage()
                viewState.productMetadata = foodMetadata
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
