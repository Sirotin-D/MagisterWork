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
                HStack {
                    IconButton(systemName: IconNames.PhotoSystemIcon) {
                        viewModel.photoLibraryImagePickerClicked()
                    }
                    
                    IconButton(systemName: IconNames.CameraSystemIcon) {
                        viewModel.cameraImagePickerClicked()
                    }
                    
                    IconButton(systemName: IconNames.VideoSystemIcon) {
                        viewModel.liveImageClassificationClicked()
                    }
                }
                
                ImagePreview(image: uiImage)
                
                IconButton(systemName: IconNames.BoltSystemIcon) {
                    if let image = uiImage {
                        viewModel.imageSelected(for: image)
                    }
                }
                
                PredictionResultsView(predictionsResult: viewModel.homeViewState.predictionsResult, timeElapsed: viewModel.homeViewState.timeElapsed)
                    .padding()
                if (viewModel.homeViewState.isLoading) {
                    ProgressView()
                }
            }
            .navigationDestination(isPresented: $viewModel.homeViewState.isShowLiveCamera, destination: {
                LiveCameraView()
                    .toolbar(.hidden, for: .tabBar)
            })
            .alert(viewModel.homeViewState.alertMessage, isPresented: $viewModel.homeViewState.isShowAlert) {
                Button(Constants.Ok, role: .cancel) {
                    viewModel.alertClosed()
                }
            }
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
        static let Ok: LocalizedStringKey = "Ok"
    }
    
    private enum IconNames {
        static let PhotoSystemIcon = "photo"
        static let CameraSystemIcon = "camera"
        static let VideoSystemIcon = "video"
        static let BoltSystemIcon = "bolt.fill"
    }
}

struct ImagePreview: View {
    let image: UIImage?
    var body: some View {
        Rectangle()
            .strokeBorder()
            .foregroundColor(.blue)
            .overlay {
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFit()
                }
            }
    }
}

#Preview {
    HomeView()
}
