//
//  FoodMetadataModel.swift
//

import Foundation

struct ProductMetadataModel {
    let name: String
    let calories: Double
}

extension ProductMetadataModel {
    static func getMockData() -> ProductMetadataModel {
        MockFoodDescription.applePieMetadata
    }
}
