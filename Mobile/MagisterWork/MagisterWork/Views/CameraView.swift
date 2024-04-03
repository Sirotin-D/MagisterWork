//
//  CameraView.swift
//

import SwiftUI

struct CameraView: View {
    @State private var uiImage: UIImage?
    @ObservedObject private var viewModel = CameraViewModel()
    
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
                            if let predictionResult = viewModel.cameraState.predictionsResult {
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
                            if !viewModel.cameraState.timeElapsed.isEmpty {
                                Text("\(viewModel.cameraState.timeElapsed) sec.")
                                    .bold()
                            } else {
                                Text(Constants.UnknownValue)
                                    .bold()
                            }
                        }
                    }
                    .padding()
                    if (viewModel.cameraState.isLoading) {
                        ProgressView()
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.cameraState.isShowAlert, destination: {
                LiveCameraView()
                    .toolbar(.hidden, for: .tabBar)
            })
            .sheet(isPresented: $viewModel.cameraState.isPresenting){
                ImagePicker(uiImage: $uiImage, isPresenting: $viewModel.cameraState.isPresenting, sourceType: $viewModel.cameraState.imageSourceType)
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

extension CameraView {
    private enum Constants {
        static let CameraTitle = "Камера"
        static let ImageCategories = "Категории фото"
        static let TimeElapsed = "Время затрачено"
        static let PersentSign = "%"
        static let UnknownValue = "NA"
        static let SecondsMeasure = "сек."
        static let LiveImageClassificationImplementationMessage = "Функционал классификации изображений в режиме видео ещё не реализован"
        static let Ok = "Ок"
    }
    
    private enum IconNames {
        static let PhotoSystemIcon = "photo"
        static let CameraSystemIcon = "camera"
        static let VideoSystemIcon = "video"
        static let BoltSystemIcon = "bolt.fill"
    }
}

#Preview {
    CameraView()
}
