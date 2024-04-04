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
                    
                    HStack() {
                        VStack {
                            Text("\(Constants.ImageCategories):")
                            if let predictionResult = viewModel.homeViewState.predictionsResult {
                                ForEach(predictionResult) { prediction in
                                    HStack {
                                        Text("\(prediction.classification) - \(prediction.confidencePercentage) %")
                                            .bold()
                                            .font(.subheadline)
                                    }
                                }
                            } else {
                                Text(Constants.UnknownValue)
                                    .bold()
                            }
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("\(Constants.TimeElapsed):")
                            if !viewModel.homeViewState.timeElapsed.isEmpty {
                                Text("\(viewModel.homeViewState.timeElapsed) \(Constants.SecondsMeasure).")
                                    .bold()
                            } else {
                                Text(Constants.UnknownValue)
                                    .bold()
                            }
                        }
                    }
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
    private enum Constants {
        static let ImageCategories = "Категории фото"
        static let TimeElapsed = "Время затрачено"
        static let PersentSign = "%"
        static let UnknownValue = "NA"
        static let SecondsMeasure = "сек"
    }
    
    private enum IconNames {
        static let PhotoSystemIcon = "photo"
        static let CameraSystemIcon = "camera"
        static let VideoSystemIcon = "video"
        static let BoltSystemIcon = "bolt.fill"
    }
}

#Preview {
    HomeView()
}
