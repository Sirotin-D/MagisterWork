//
//  HomeViewModel.swift
//

import SwiftUI

class HomeViewModel: BaseViewModel {
    @Published var homeViewState = HomeViewState()
    private var predictor = ImagePredictor.shared
    private let kLogTag = "HomeViewModel"
    
    func imageSelected(for photo: UIImage?) {
        guard homeViewState.imagePickerDataChanged else { return }
        homeViewState.imagePickerDataChanged = false
        if let photo = photo {
            predictImage(for: photo)
        }
    }
    
    func predictionButtonClicked(for photo: UIImage?) {
        if let photo = photo {
            predictImage(for: photo)
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
    
    func foodLabelClicked(foodName: String) {
        homeViewState.selectedFoodName = foodName
        homeViewState.isShowFoodDescription = true
    }
    
    //MARK: - Private methods
    
    private func predictImage(for photo: UIImage) {
        homeViewState.isLoading = true
        homeViewState.timeElapsed = ""
        homeViewState.predictionsResult = nil
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let startTime = CFAbsoluteTimeGetCurrent()
                try self.predictor.makePredictions(for: photo) { [weak self] predictions in
                    guard let self = self else { return }
                    guard let predictions = predictions else {
                        Logger.shared.e(self.kLogTag, "No predictions. Check console log.")
                        DispatchQueue.main.async {
                            self.homeViewState.isLoading = false
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        var predictionsToShow = 2
                        if let mostLikelyObject = predictions.first {
                            if mostLikelyObject.confidencePercentage >= 80 {
                                predictionsToShow = 1
                            }
                        }
                        self.homeViewState.predictionsResult = predictions.prefix(predictionsToShow).map{ prediction in
                            guard let foodObject = FoodService.getFoodObject(for: prediction.classification) else {
                                return prediction
                            }
                            return Prediction(classification: foodObject.getValue(), confidencePercentage: prediction.confidencePercentage)
                        }
                        self.homeViewState.isLoading = false
                        let timeDuration = CFAbsoluteTimeGetCurrent() - startTime
                        self.homeViewState.timeElapsed = Utils.formatElapsedTime(timeDuration)
                    }
                }
            } catch {
                Logger.shared.e(self.kLogTag, "Vision was unable to make a prediction: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.homeViewState.isLoading = false
                }
            }
        }
    }
    
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
        homeViewState.imageSourceType = .photoLibrary
        homeViewState.isShowImagePicker = true
    }
    
    private func showPhotoCamera() {
        homeViewState.imageSourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
        ? .camera : .photoLibrary
        homeViewState.isShowImagePicker = true
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
        var isShowFoodDescription = false
        var predictionsResult: [Prediction]?
        var timeElapsed: String = ""
        var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
        var isOpenLiveCamera = false
        var alertModel = AlertModel()
        var isShowAlert = false
        var imagePickerDataChanged = false
        var selectedFoodName: String? = nil
    }
    
    private enum Constants {
        static let AlertMessage: LocalizedStringKey = "Please allow access to resource in the settings to continue"
        static let OpenSettignsActionButtonTitle: LocalizedStringKey = "Open Settings"
    }
}
