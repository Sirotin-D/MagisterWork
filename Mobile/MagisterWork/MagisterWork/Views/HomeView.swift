//
//  HomeView.swift
//

import SwiftUI

struct HomeView: View {
    @State private var uiImage: UIImage?
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Image(systemName: IconNames.PhotoSystemIcon)
                        .onTapGesture {
                            viewModel.photoLibraryImagePickerClicked()
                        }
                    Image(systemName: IconNames.CameraSystemIcon)
                        .onTapGesture {
                            viewModel.cameraImagePickerClicked()
                        }
                    Image(systemName: IconNames.VideoSystemIcon)
                        .onTapGesture {
                            viewModel.liveImageClassificationClicked()
                        }
                }
                .font(.title)
                .foregroundColor(.blue)
                
                Rectangle()
                    .strokeBorder()
                    .foregroundColor(.blue)
                    .overlay(
                        Group {
                            if uiImage != nil {
                                Image(uiImage: uiImage!)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    )
                
                VStack{
                    Button(action: {
                        if let uiImage = uiImage {
                            viewModel.imageSelected(for: uiImage)
                        }
                    }) {
                        Image(systemName: IconNames.BoltSystemIcon)
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                    
                    PredictionResultsView(predictionsResult: viewModel.homeViewState.predictionsResult, timeElapsed: viewModel.homeViewState.timeElapsed)
                    .padding()
                    if (viewModel.homeViewState.isLoading) {
                        ProgressView()
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.homeViewState.isShowAlert, destination: {
                LiveCameraView()
                    .toolbar(.hidden, for: .tabBar)
            })
            .sheet(isPresented: $viewModel.homeViewState.isPresenting){
                ImagePicker(uiImage: $uiImage, isPresenting: $viewModel.homeViewState.isPresenting, sourceType: viewModel.homeViewState.imageSourceType)
                    .onDisappear{
                        if let uiImage = uiImage {
                            viewModel.imageSelected(for: uiImage)
                        }
                    }
            }
            .padding()
        }
    }
}

extension HomeView {
    private enum IconNames {
        static let PhotoSystemIcon = "photo"
        static let CameraSystemIcon = "camera"
        static let VideoSystemIcon = "video"
        static let BoltSystemIcon = "bolt.fill"
    }
}

struct PredictionResultsView: View {
    let predictionsResult: [Prediction]?
    let timeElapsed: String
    var body: some View {
        HStack() {
            VStack {
                Text(Constants.ImageCategories)
                if let predictionResult = predictionsResult {
                    ForEach(predictionResult) { prediction in
                        Text("\(prediction.classification) - \(prediction.confidencePercentage) %")
                            .bold()
                            .font(.subheadline)
                    }
                } else {
                    Text(Constants.UnknownValue)
                        .bold()
                }
            }
            Spacer()
            VStack {
                Text(Constants.TimeElapsed)
                if !timeElapsed.isEmpty {
                    Text("\(timeElapsed) sec.")
                        .bold()
                } else {
                    Text(Constants.UnknownValue)
                        .bold()
                }
            }
        }
    }
}

extension PredictionResultsView {
    private enum Constants {
        static let ImageCategories: LocalizedStringKey = "Image categories:"
        static let TimeElapsed: LocalizedStringKey = "Time elapsed:"
        static let PersentSign = "%"
        static let UnknownValue = "NA"
    }
}

#Preview {
    HomeView()
}
