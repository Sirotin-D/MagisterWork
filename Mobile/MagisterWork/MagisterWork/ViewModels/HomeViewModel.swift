//
//  HomeViewModel.swift
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var homeViewState = HomeViewState()
    private var predictor = ImagePredictor()
    private let predictionsToShow = 2
    private let kLogTag = "HomeViewModel"
    
    func imageSelected(for photo: UIImage) {
        homeViewState.isLoading = true
        homeViewState.timeElapsed = ""
        homeViewState.predictionsResult = nil
        let startTime = CFAbsoluteTimeGetCurrent()
        
        do {
            try predictor.makePredictions(for: photo) { predictions in
                guard let predictions = predictions else {
                    Logger.shared.e(self.kLogTag, "No predictions. Check console log.")
                    self.homeViewState.isLoading = false
                    return
                }
                
                self.homeViewState.predictionsResult = predictions.prefix(self.predictionsToShow).map{ prediction in
                    Prediction(classification: prediction.classification, confidencePercentage: prediction.confidencePercentage)
                }
                self.homeViewState.isLoading = false
                let endTime = CFAbsoluteTimeGetCurrent() - startTime
                self.homeViewState.timeElapsed = Utils.formatElapsedTime(endTime)
            }
        } catch {
            Logger.shared.e(kLogTag, "Vision was unable to make a prediction: \(error.localizedDescription)")
        }
    }

    func photoLibraryImagePickerClicked() {
        let isPhotoLibraryPermissionAccessed = PermissionManager.shared.getPermissionStatus(for: .PhotoLibrary)
        if isPhotoLibraryPermissionAccessed {
            showPhotoLibrary()
        } else {
            PermissionManager.shared.requestPermission(for: .PhotoLibrary) { permissionStatus in
                DispatchQueue.main.async {
                    if permissionStatus {
                        self.showPhotoLibrary()
                    } else {
                        self.permissionStatusDenied(type: .PhotoLibrary)
                    }
                }
            }
        }
    }
    
    func cameraImagePickerClicked() {
        let isPhotoLibraryPermissionAccessed = PermissionManager.shared.getPermissionStatus(for: .Camera)
        if isPhotoLibraryPermissionAccessed {
            showPhotoCamera()
        } else {
            PermissionManager.shared.requestPermission(for: .Camera) { permissionStatus in
                DispatchQueue.main.async {
                    if permissionStatus {
                        self.showPhotoCamera()
                    } else {
                        self.permissionStatusDenied(type: .Camera)
                    }
                }
            }
        }
    }
    
    func liveImageClassificationClicked() {
        let isPhotoLibraryPermissionAccessed = PermissionManager.shared.getPermissionStatus(for: .Camera)
        if isPhotoLibraryPermissionAccessed {
            showLiveCamera()
        } else {
            PermissionManager.shared.requestPermission(for: .Camera) { permissionStatus in
                DispatchQueue.main.async {
                    if permissionStatus {
                        self.showLiveCamera()
                    } else {
                        self.permissionStatusDenied(type: .Camera)
                    }
                }
            }
        }
    }
    
    func alertClosed() {
        homeViewState.alertMessage = ""
    }
    
    private func permissionStatusDenied(type: PermissionType) {
        let resourceName = type == .Camera ? Constants.camera : Constants.photoLibrary
        showAlert(message: String(format: Constants.alertMessage, resourceName))
    }
    
    private func showPhotoLibrary() {
        self.homeViewState.isPresenting = true
        self.homeViewState.imageSourceType = .photoLibrary
    }
    
    private func showPhotoCamera() {
        homeViewState.isPresenting = true
        homeViewState.imageSourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
        ? .camera : .photoLibrary
    }
    
    private func showLiveCamera() {
        homeViewState.isShowLiveCamera = true
    }
    
    private func showAlert(message: String) {
        homeViewState.isShowAlert = true
        homeViewState.alertMessage = message
    }
}

extension HomeViewModel {
    public struct HomeViewState {
        var isLoading = false
        var isPresenting = false
        var predictionsResult: [Prediction]?
        var timeElapsed: String = ""
        var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
        var isShowLiveCamera = false
        var alertMessage: String = ""
        var isShowAlert = false
    }
    
    private enum Constants {
        static let camera = "камере"
        static let photoLibrary = "галерее"
        static let alertMessage = "Пожалуйста, разрешите доступ к %@ в настройках, чтобы продолжить"
    }
}
