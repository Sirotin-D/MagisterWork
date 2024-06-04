//
//  FoodMetadataModel.swift
//

import Foundation

struct ProductMetadataModel {
    let name: String
    let calories: Double
    let proteins: Double
    let fats: Double
    let carbohydrates: Double
}

extension ProductMetadataModel {
    static func getMockData() -> ProductMetadataModel {
        MockFoodDescription.applePieMetadata
    }
}

struct FoodDescriptionModel: Decodable {
    let name: String
    let calories: Double
    let serving_size_g: Double
    let fat_total_g: Double
    let fat_saturated_g: Double
    let protein_g: Double
    let sodium_mg: Double
    let potassium_mg: Double
    let cholesterol_mg: Double
    let carbohydrates_total_g: Double
    let fiber_g: Double
    let sugar_g: Double
}

extension FoodDescriptionModel {
    static func getMockData() -> FoodDescriptionModel {
        FoodDescriptionModel(
            name: "Apple pie",
            calories: 0.0,
            serving_size_g: 0.0,
            fat_total_g: 0,
            fat_saturated_g: 0,
            protein_g: 0,
            sodium_mg: 0,
            potassium_mg: 0,
            cholesterol_mg: 0,
            carbohydrates_total_g: 0,
            fiber_g: 0,
            sugar_g: 0
        )
    }
}
