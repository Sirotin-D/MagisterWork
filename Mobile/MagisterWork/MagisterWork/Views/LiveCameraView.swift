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
            
            IconButton(
                systemName: IconNames.BoltSystemIcon,
                color: viewModel.liveCameraViewState.activateButtonColor
            ) {
                viewModel.activateButtonClicked()
            }
            
            PredictionResultsView(
                predictionsResult: viewModel.liveCameraViewState.predictionsResult,
                timeElapsed: viewModel.liveCameraViewState.timeElapsed,
                predictionClicked: viewModel.foodLabelClicked
            )
            .padding()
            .navigationDestination(isPresented: $viewModel.liveCameraViewState.isShowFoodDescription) {
                if let foodName = viewModel.liveCameraViewState.selectedFoodName {
                    FoodDescriptionView(foodName: foodName)
                }
            }
        }
        .onAppear() {
            viewModel.onAppear()
        }
        .onDisappear() {
            viewModel.onDisappear()
        }
//        .sheet(isPresented: $viewModel.liveCameraViewState.isShowFoodDescription){
//            if let foodName = viewModel.liveCameraViewState.selectedFoodName {
//                FoodDescriptionView(foodName: foodName)
//            }
//        }
    }
}

extension LiveCameraView {
    struct IconNames {
        static let BoltSystemIcon = "bolt.fill"
    }
}

#Preview {
    LiveCameraView()
}
