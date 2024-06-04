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
                    Text(metadata.name.localized).font(.title)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    HStack {
                        VStack(alignment: .leading, spacing: Paddings.smallSpacing) {
                            Text(Constants.Calories)
                                .bold()
                            Text(String(metadata.calories))
                            
                            Text(Constants.Proteins)
                                .bold()
                            Text(String(metadata.proteins))
                            
                            Text(Constants.Fats)
                                .bold()
                            Text(String(metadata.fats))
                            
                            Text(Constants.Carbohydrates)
                                .bold()
                            Text(String(metadata.carbohydrates))
                        }
                        .font(.title)
                        
                        Spacer()
                    }
                }
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
        static let Calories: LocalizedStringKey = "Calories (100g):"
        static let Proteins: LocalizedStringKey = "Proteins (g):"
        static let Fats: LocalizedStringKey = "Fats (g):"
        static let Carbohydrates: LocalizedStringKey = "Carbohydrates (g):"
        static let FoodImagePlaceholder = "FoodPlaceholder"
    }
    
    private enum Paddings {
        static let smallSpacing: CGFloat = 5
        static let mediumSpacing: CGFloat = 10
    }
}

#Preview {
    FoodDescriptionView(foodName: FoodObject.getMockFoodName())
}
