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
                    IconButton(
                        systemName: IconNames.PhotoSystemIcon,
                        enabled: !viewModel.homeViewState.isLoading,
                        action: viewModel.photoLibraryImagePickerClicked
                    )
                    
                    IconButton(
                        systemName: IconNames.CameraSystemIcon,
                        enabled: !viewModel.homeViewState.isLoading,
                        action: viewModel.cameraImagePickerClicked
                    )
                    
                    IconButton(
                        systemName: IconNames.VideoSystemIcon,
                        enabled: !viewModel.homeViewState.isLoading,
                        action: viewModel.liveImageClassificationClicked
                    )
                }
                
                ImagePreview(image: uiImage)
                
                IconButton(
                    systemName: IconNames.BoltSystemIcon,
                    enabled: !viewModel.homeViewState.isLoading
                ) {
                    viewModel.predictionButtonClicked(for: uiImage)
                }
                
                PredictionResultsView(
                    predictionsResult: viewModel.homeViewState.predictionsResult,
                    timeElapsed: viewModel.homeViewState.timeElapsed
                )
                .padding(.top, Paddings.Medium)
                
                if (viewModel.homeViewState.isLoading) {
                    ProgressView().tint(.blue)
                }
                
                Spacer()
            }
            .navigationDestination(isPresented: $viewModel.homeViewState.isOpenLiveCamera) {
                LiveCameraView()
                    .toolbar(.hidden, for: .tabBar)
            }
            .alert(viewModel.homeViewState.alertModel.title, isPresented: $viewModel.homeViewState.isShowAlert, actions: {
                Button(Constants.Ok, role: .cancel) {
                    viewModel.onAlertClosed()
                }
                if viewModel.homeViewState.alertModel.isActionButtonEnabled {
                    Button(viewModel.homeViewState.alertModel.actionButtonTitle) {
                        viewModel.homeViewState.alertModel.actionButtonHandler?()
                    }
                }
            }, message: {
                Text(viewModel.homeViewState.alertModel.message)
            })
            .sheet(isPresented: $viewModel.homeViewState.isShowImagePicker) {
                ImagePicker(
                    uiImage: $uiImage,
                    isPresenting: $viewModel.homeViewState.isShowImagePicker,
                    newImageSelected: $viewModel.homeViewState.imagePickerDataChanged,
                    sourceType: viewModel.homeViewState.imageSourceType
                )
                .onDisappear {
                    viewModel.imageSelected(for: uiImage)
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
    
    private enum Paddings {
        static let Medium = CGFloat(10)
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
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding(.all, CGFloat(1))
                }
            }
    }
}

#Preview {
    HomeView()
}
