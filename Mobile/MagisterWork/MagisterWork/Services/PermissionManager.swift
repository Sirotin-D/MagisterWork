//
//  PermissionManager.swift
//

import AVFoundation
import Photos

class PermissionManager {
    static func getPermissionStatus(for permission: PermissionType) -> Bool {
        var permissionStatus = false
        switch permission {
        case .PhotoLibrary:
            permissionStatus = getPhotoLibraryPermissionStatus()
        case .Camera:
            permissionStatus = getCameraPermissionStatus()
        }
        return permissionStatus
    }
    
    static func requestPermission(for permission: PermissionType) async -> Bool {
        var isPermissionAccessed = false
        switch permission {
        case .PhotoLibrary:
            isPermissionAccessed = await requestPhotoLibraryPermissionStatus()
        case .Camera:
            isPermissionAccessed = await requestCameraPermissionStatus()
        }
        return isPermissionAccessed
    }
    
    //MARK: - Private methods
    
    private static func getCameraPermissionStatus() -> Bool {
        let cameraAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
        let isCameraAuthAccessed = cameraAuthStatus == .authorized
        return isCameraAuthAccessed
    }
    
    private static func getPhotoLibraryPermissionStatus() -> Bool {
        let photoLibrary = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        let isPhotoLibraryAuthAccessed = photoLibrary == .authorized
        return isPhotoLibraryAuthAccessed
    }
    
    private static func requestCameraPermissionStatus() async -> Bool {
        await AVCaptureDevice.requestAccess(for: .video)
    }
    
    private static func requestPhotoLibraryPermissionStatus() async -> Bool {
        await PHPhotoLibrary.requestAuthorization(for: .addOnly) == .authorized
    }
}

enum PermissionType {
    case PhotoLibrary
    case Camera
}
