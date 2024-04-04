//
//  LiveCameraView.swift
//

import SwiftUI

struct LiveCameraView: View {
    @ObservedObject private var viewModel = LiveCameraViewModel()
    var body: some View {
        VStack {
            if let captureSession = viewModel.liveCameraViewState.captureSesion {
                CameraPreviewView(session: captureSession)
            }
            HStack() {
                VStack {
                    Text("\(Constants.ImageCategories):")
                    if let predictionResult = viewModel.liveCameraViewState.predictionsResult {
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
                    if !viewModel.liveCameraViewState.timeElapsed.isEmpty {
                        Text("\(viewModel.liveCameraViewState.timeElapsed) \(Constants.SecondsMeasure).")
                            .bold()
                    } else {
                        Text(Constants.UnknownValue)
                            .bold()
                    }
                }
            }
            .padding()
        }
        .onAppear() {
            viewModel.onAppear()
        }
        .onDisappear() {
            viewModel.onDisappear()
        }
    }
}

extension LiveCameraView {
    private struct Constants {
        static let ImageCategories = "Категории фото"
        static let TimeElapsed = "Время затрачено"
        static let PersentSign = "%"
        static let UnknownValue = "NA"
        static let SecondsMeasure = "сек"
    }
}

#Preview {
    LiveCameraView()
}
