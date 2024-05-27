//
//  FoodDescriptionView.swift
//  MagisterWork
//
//  Created by user on 22.05.2024.
//

import SwiftUI

struct FoodDescriptionView: View {
    @ObservedObject var viewModel: FoodDescriptionViewModel
    
    init(foodName: String) {
        viewModel = FoodDescriptionViewModel(selectedImageName: foodName)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Paddings.mediumSpacing) {
            if let productUIimage = viewModel.viewState.productImage {
                Image(uiImage: productUIimage)
                    .resizable()
                    .scaledToFit()
            } else {
                if let placeholder = UIImage(named: Constants.FoodImagePlaceholder) {
                    Image(uiImage: placeholder)
                        .resizable()
                        .scaledToFit()
                }
            }
            if let metadata = viewModel.viewState.productMetadata {
                VStack(alignment: .leading) {
                    Text(metadata.name.localized)
                    Text(Constants.Calories)
                        .bold()
                    Text(String(metadata.calories))
                }
                .font(.title)
            }
            Spacer()
        }
        .padding()
        
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

extension FoodDescriptionView {
    private enum Constants {
        static let Calories: LocalizedStringKey = "Calories:"
        static let FoodImagePlaceholder = "FoodPlaceholder"
    }
    
    private enum Paddings {
        static let mediumSpacing: CGFloat = 10
    }
}

#Preview {
    FoodDescriptionView(foodName: "Apple")
}
