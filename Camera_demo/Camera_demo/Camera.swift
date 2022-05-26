//
//  Camera.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/19.
//  reference: https://guides.codepath.com/ios/Creating-a-Custom-Camera-View

import Foundation
import RxSwift
import AVFoundation
import Combine

class Camera: NSObject {
    
    var session = AVCaptureSession()
    var deviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    
    var photoData = Data(count: 0)
    var capturePhotoPreview: PublishSubject<Data> = PublishSubject<Data>()
    var photoPreview: PassthroughSubject<Data, Error> = PassthroughSubject<Data, Error>()
    var flashMode: BehaviorSubject<AVCaptureDevice.FlashMode> = BehaviorSubject<AVCaptureDevice.FlashMode>(value: .off)
    var cameraPositoin: BehaviorSubject<AVCaptureDevice.Position> = BehaviorSubject<AVCaptureDevice.Position>(value: .back)
    var slientMode: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    override init() {
        super.init()
        checkForPermissionCamera()
    }
    
    func setUpCamera() {
        session.sessionPreset = .medium
        
        // setting input & output
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            do {
                deviceInput = try AVCaptureDeviceInput(device: device)
                
                if session.canAddInput(deviceInput) {
                    session.addInput(deviceInput)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization = .quality
                }
                
                
            } catch {
                print(error)
            }
            
        }
        
    }
    
    
    
    func checkForPermissionCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUpCamera()
        case .denied, .restricted:
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] grant in
                if grant {
                    DispatchQueue.main.async {
                        self?.setUpCamera()
                    }
                }
                
            }
            
        @unknown default:
            break
        }
    }
    
    
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
        output.capturePhoto(with: settings, delegate: self)
        
    }
    
    func savePhoto() {
        
    }
    
    
    
}
extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
        
        capturePhotoPreview.onNext(imageData)
        photoPreview.send(imageData)
        DispatchQueue.global().async {
            UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData)!, self, nil, nil)
        }
    }
}
