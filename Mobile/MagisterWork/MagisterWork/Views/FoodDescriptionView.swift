//
//  FoodDescriptionView.swift
//

import SwiftUI

struct FoodDescriptionView: View {
    @ObservedObject var viewModel: FoodDescriptionViewModel
    
    init(foodName: String) {
        viewModel = FoodDescriptionViewModel(selectedImageName: foodName)
    }
    
    var body: some View {
        VStack(spacing: Paddings.mediumSpacing) {
            if let productUIimage = viewModel.viewState.productImage {
                Image(uiImage: productUIimage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                if let placeholder = UIImage(named: Constants.FoodImagePlaceholder) {
                    Image(uiImage: placeholder)
                        .resizable()
                        .scaledToFit()
                }
            }
            
            if viewModel.viewState.isLoading {
                ProgressView().tint(.blue)
            }
            
            if let metadata = viewModel.viewState.productMetadata {
                VStack {
                    Text(metadata.name.localized)
                    
                    HStack {
                        Text(Constants.Calories)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text(String(metadata.calories))
                        Spacer()
                    }
                    
                    HStack {
                        Text(Constants.Proteins)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text(String(metadata.proteins))
                        Spacer()
                    }
                    
                    HStack {
                        Text(Constants.Fats)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text(String(metadata.fats))
                        Spacer()
                    }
                    
                    HStack {
                        Text(Constants.Carbohydrates)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text(String(metadata.carbohydrates))
                        Spacer()
                    }
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
        static let Proteins: LocalizedStringKey = "Proteins (g):"
        static let Fats: LocalizedStringKey = "Fats (g):"
        static let Carbohydrates: LocalizedStringKey = "Carbohydrates (g):"
        static let FoodImagePlaceholder = "FoodPlaceholder"
    }
    
    private enum Paddings {
        static let mediumSpacing: CGFloat = 10
    }
}

#Preview {
    FoodDescriptionView(foodName: FoodObject.getMockFoodName())
}
