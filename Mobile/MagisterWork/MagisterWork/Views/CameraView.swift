//
//  CameraView.swift
//

import SwiftUI

struct CameraView: View {
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var uiImage: UIImage?
    @ObservedObject private var viewModel = CameraViewModel()
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: IconNames.PhotoSystemIcon)
                    .onTapGesture {
                        viewModel.isPresenting = true
                        sourceType = .photoLibrary
                    }
                Image(systemName: IconNames.CameraSystemIcon)
                    .onTapGesture {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            viewModel.isPresenting = true
                            sourceType = .camera
                        } else {
                            viewModel.isPresenting = true
                            sourceType = .photoLibrary
                        }
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
                        if let predictionResult = viewModel.predictionsResult {
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
                        if !viewModel.timeElapsed.isEmpty {
                            Text("\(viewModel.timeElapsed) sec.")
                                .bold()
                        } else {
                            Text(Constants.UnknownValue)
                                .bold()
                        }
                    }
                }
                .padding()
                if (viewModel.isLoading) {
                    ProgressView()
                }
            }
        }
        .sheet(isPresented: $viewModel.isPresenting){
            ImagePicker(uiImage: $uiImage, isPresenting:  $viewModel.isPresenting, sourceType: $sourceType)
                .onDisappear{
                    if let uiImage = uiImage {
                        viewModel.imageSelected(for: uiImage)
                    }
                }
        }
        .padding()
    }
}

extension CameraView {
    private enum Constants {
        static let CameraTitle = "Камера"
        static let ImageCategories = "Категории фото"
        static let TimeElapsed = "Время затрачено"
        static let UnknownValue = "NA"
    }
    
    private enum IconNames {
        static let PhotoSystemIcon = "photo"
        static let CameraSystemIcon = "camera"
        static let BoltSystemIcon = "bolt.fill"
    }
}

#Preview {
    CameraView()
}
