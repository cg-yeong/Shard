//
//  Camera.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/19.
//

import Foundation
import RxSwift
import AVFoundation

class Camera: NSObject {
    
    var session = AVCaptureSession()
    var deviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    
    var photoData = Data(count: 0)
    
    var flashMode: BehaviorSubject<AVCaptureDevice.FlashMode> = BehaviorSubject<AVCaptureDevice.FlashMode>(value: .off)
    var cameraPositoin: BehaviorSubject<AVCaptureDevice.Position> = BehaviorSubject<AVCaptureDevice.Position>(value: .back)
    var slientMode: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    func setUpCamera() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            
            
        }
    }
    
    
}
