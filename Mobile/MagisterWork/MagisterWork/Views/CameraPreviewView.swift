//
//  LiveCameraPreviewView.swift
//

import SwiftUI
import AVKit
import Vision


struct CameraPreviewView: UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspect
        view.videoPreviewLayer.connection?.videoOrientation = .portrait
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {}

    typealias UIViewType = VideoPreviewView

    class VideoPreviewView: UIView {
       override class var layerClass: AnyClass {
          AVCaptureVideoPreviewLayer.self
       }
    
       var videoPreviewLayer: AVCaptureVideoPreviewLayer {
          return layer as! AVCaptureVideoPreviewLayer
       }
    }
}
