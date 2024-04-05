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
            
            PredictionResultsView(predictionsResult: viewModel.liveCameraViewState.predictionsResult, timeElapsed: viewModel.liveCameraViewState.timeElapsed)
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

#Preview {
    LiveCameraView()
}
