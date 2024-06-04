//
//  FoodDescriptionInteractor.swift
//

import Foundation

class FoodDescriptionInteractor {
    private let service = FoodService()
    
    func fetchFoodDescription(foodName: String) async -> FoodDescriptionModel? {
        await service.fetchFoodDescription(foodName: foodName)
    }
    
    func getMockFoodDescription(foodName: String) async -> ProductMetadataModel? {
        service.getMockFoodDescription(foodName: foodName)
    }
}
