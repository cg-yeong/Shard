//
//  Permission.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/16.
//

import Foundation
import AVFoundation
import Photos

protocol CameraPermission {}
protocol PhotoPermission {}

class Permission: CameraPermission {

    enum requestType {
        case Camera
    }
    
    static let sharedInstance: Permission = {
        return Permission()
    }()
    
    func request(_ type: requestType, completionHandler: ((Bool) -> Void)? = nil) {
        switch type {
        case .Camera:
            requestAuthorizationCamera(completionHandler)
        }
    }
    
}

extension CameraPermission {
    static func requestAuthorizationCamera(_ completion: ((Bool) -> Void)? = nil) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if let completion = completion {
                completion(response)
            }
        }
    }
    
    func requestAuthorizationCamera(_ completion: ((Bool) -> Void)? = nil) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if let completion = completion {
                completion(response)
            }
        }
    }
    
    func verifyAuthorizationCamera(_ completion: ((Bool) -> Void)? = nil) {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                if granted {
                    if let completion = completion {
                        completion(granted)
                    }
                } else {
                    print("카메라 권한허용 안됨")
                }
            }
        case .denied:
            print("카메라 권한허용 거부됨")
        case .restricted:
            print("카메라 권한허용 제한됨")
        case .authorized:
            print("카메라 권한허용 완료")
            return
        @unknown default:
            fatalError()
        }
    }
}

extension PhotoPermission {
    static func requestAuthorizationPhotos(_ completion: ((Bool) -> Void)? = nil) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status: PHAuthorizationStatus) in
                if let completion = completion {
                    if status == .authorized {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) in
                if let completion = completion {
                    if status == .authorized {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
            }
            
        }
    }
    
    func requestAuthorizationPhotos(_ completion: ((Bool) -> Void)? = nil) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status: PHAuthorizationStatus) in
                if let completion = completion {
                    if status == .authorized {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) in
                if let completion = completion {
                    if status == .authorized {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
            }
            
        }
    }
    
    func verifyAuthorizationPhotos(_ completion: ((Bool) -> Void)? = nil) {
        
    }
    
}
