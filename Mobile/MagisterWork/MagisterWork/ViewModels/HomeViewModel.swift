//
//  HomeViewModel.swift
//

import SwiftUI

class HomeViewModel: BaseViewModel {
    @Published var homeViewState = HomeViewState()
    private var predictor = ImagePredictor()
    private let predictionsToShow = 2
    private let kLogTag = "HomeViewModel"
    
    func imageSelected(for photo: UIImage) {
        homeViewState.isLoading = true
        homeViewState.timeElapsed = ""
        homeViewState.predictionsResult = nil
        let startTime = CFAbsoluteTimeGetCurrent()
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try self.predictor.makePredictions(for: photo) { [weak self] predictions in
                    guard let self = self else { return }
                    guard let predictions = predictions else {
                        Logger.shared.e(self.kLogTag, "No predictions. Check console log.")
                        self.homeViewState.isLoading = false
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.homeViewState.predictionsResult = predictions.prefix(self.predictionsToShow).map{ prediction in
                            Prediction(classification: prediction.classification, confidencePercentage: prediction.confidencePercentage)
                        }
                        self.homeViewState.isLoading = false
                        let endTime = CFAbsoluteTimeGetCurrent() - startTime
                        self.homeViewState.timeElapsed = Utils.formatElapsedTime(endTime)
                    }
                }
            } catch {
                Logger.shared.e(self.kLogTag, "Vision was unable to make a prediction: \(error.localizedDescription)")
                self.homeViewState.isLoading = false
            }
        }
    }
    
    func photoLibraryImagePickerClicked() {
        performActionIfPermissionAccessed(for: .PhotoLibrary, action: showPhotoLibrary)
    }
    
    func cameraImagePickerClicked() {
        performActionIfPermissionAccessed(for: .Camera, action: showPhotoCamera)
    }
    
    func liveImageClassificationClicked() {
        performActionIfPermissionAccessed(for: .Camera, action: showLiveCamera)
    }
    
    func onAlertClosed() {
        homeViewState.alertModel = AlertModel()
    }
    
    //MARK: - Private methods
    
    private func performActionIfPermissionAccessed(for permission: PermissionType, action: @escaping () -> Void) {
        Task(priority: .userInitiated) {
            let isPermissionAccessed = PermissionManager.getPermissionStatus(for: permission)
            if isPermissionAccessed {
                await MainActor.run {
                    action()
                }
            } else {
                let permissionRequestResult = await PermissionManager.requestPermission(for: permission)
                await MainActor.run {
                    if permissionRequestResult {
                        action()
                    } else {
                        self.permissionStatusDenied()
                    }
                }
            }
        }
    }
    
    private func permissionStatusDenied() {
        showAlert(
            AlertModel(
                title: Constants.AlertMessage,
                isActionButtonEnabled: true,
                actionButtonTitle: Constants.OpenSettignsActionButtonTitle,
                actionButtonHandler: openPhoneSettings)
        )
    }
    
    private func showPhotoLibrary() {
        homeViewState.isShowImagePicker = true
        homeViewState.imageSourceType = .photoLibrary
    }
    
    private func showPhotoCamera() {
        homeViewState.isShowImagePicker = true
        homeViewState.imageSourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
        ? .camera : .photoLibrary
    }
    
    private func showLiveCamera() {
        homeViewState.isOpenLiveCamera = true
    }
    
    private func showAlert(_ alertModel: AlertModel) {
        homeViewState.isShowAlert = true
        homeViewState.alertModel = alertModel
    }
    
    private func openPhoneSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}

extension HomeViewModel {
    public struct HomeViewState {
        var isLoading = false
        var isShowImagePicker = false
        var predictionsResult: [Prediction]?
        var timeElapsed: String = ""
        var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
        var isOpenLiveCamera = false
        var alertModel = AlertModel()
        var isShowAlert = false
    }
    
    private enum Constants {
        static let AlertMessage: LocalizedStringKey = "Please allow access to resource in the settings to continue"
        static let OpenSettignsActionButtonTitle: LocalizedStringKey = "Open Settings"
    }
}
