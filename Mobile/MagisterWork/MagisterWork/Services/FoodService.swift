//
//  FoodService.swift
//

import Foundation

protocol IFoodService {
    static func fetchFoodNutrition(foodName: String) async -> FoodNutritionFactsModel?
}

class FoodService: IFoodService {
    private static let kLogTag = "FoodService"
    private static let nutritionApiUrl = "https://api.api-ninjas.com/v1/nutrition?query="
    
    static func fetchFoodNutrition(foodName: String) async -> FoodNutritionFactsModel? {
        var nutritionFactsResponseModel: FoodNutritionFactsModel?
        let formattedUrl = nutritionApiUrl + foodName
        guard let url = URL(string: formattedUrl) else {return nil}
        var request = URLRequest(url: url)
        let nutritionApiKey = KeyConstants.APIKeys.nutritionAPIKey
        request.setValue(nutritionApiKey, forHTTPHeaderField: "X-Api-Key")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedModel = try JSONDecoder().decode([FoodNutritionFactsModel].self, from: data)
            nutritionFactsResponseModel = decodedModel.first
        } catch {
            Logger.shared.e(kLogTag, "Error: \(error)")
        }
        
        return nutritionFactsResponseModel
    }
    
    static func getFoodObject(for classLabel: String) -> FoodObject? {
        let formattedFoodName = classLabel.replacingOccurrences(of: "_", with: " ")
        let foodName = formattedFoodName.prefix(1).uppercased() + formattedFoodName.dropFirst()
        var foodObject: FoodObject? = nil
        for product in FoodObject.allCases {
            if foodName == product.getValue() {
                foodObject = product
                break
            }
        }
        return foodObject
    }
}
