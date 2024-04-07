//
//  PermissionManager.swift
//

import AVFoundation
import Photos

class PermissionManager {
    static let shared = PermissionManager()
    
    func getPermissionStatus(for permission: PermissionType) -> Bool {
        var permissionStatus = false
        switch permission {
        case .PhotoLibrary:
            permissionStatus = getPhotoLibraryPermissionStatus()
        case .Camera:
            permissionStatus = getCameraPermissionStatus()
        }
        return permissionStatus
    }
    
    func requestPermission(for permission: PermissionType, complitionHandler: @escaping (Bool) -> Void) {
        switch permission {
        case .PhotoLibrary:
            requestPhotoLibraryPermissionStatus(complitionHandler)
        case .Camera:
            requestCameraPermissionStatus(complitionHandler)
        }
    }
    
    //MARK: - Private methods
    
    private func getCameraPermissionStatus() -> Bool {
        let cameraAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
        let isCameraAuthAccessed = cameraAuthStatus == .authorized
        return isCameraAuthAccessed
    }
    
    private func getPhotoLibraryPermissionStatus() -> Bool {
        let photoLibrary = PHPhotoLibrary.authorizationStatus()
        let isPhotoLibraryAuthAccessed = photoLibrary == .authorized
        return isPhotoLibraryAuthAccessed
    }
    
    private func requestCameraPermissionStatus(_ complitionHandler: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: complitionHandler)
    }
    
    private func requestPhotoLibraryPermissionStatus(_ complitionHandler: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { permissionStatus in
            complitionHandler(permissionStatus == .authorized)
        }
    }
}

enum PermissionType {
    case PhotoLibrary
    case Camera
}
