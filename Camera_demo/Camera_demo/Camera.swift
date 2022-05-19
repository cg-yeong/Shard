//
//  Camera.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/19.
//

import Foundation
//
//class Camera {
//    func setCaptureSession() {
//        captureSession = AVCaptureSession()
//        guard let captureSession = captureSession else {
//            return
//        }
//
//        captureSession.beginConfiguration()
//        
//        if captureSession.canSetSessionPreset(.photo) {
//            captureSession.sessionPreset = .photo
//        }
//        
//        addCaptureDeviceInput()
//        addCaptureOutput()
//    }
//    
//    func addCaptureDeviceInput() {
//        
//        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
//            backCamera = device
//        } else {
//            fatalError("후면 카메라 X")
//        }
//        
//        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
//            frontCamera = device
//        } else {
//            fatalError("전면 카메라 X")
//        }
//        
//        guard backCamera != nil, let backCameraDeviceInput = try? AVCaptureDeviceInput(device: backCamera!) else {
//            fatalError("후면 카메라로 인풋 설정 불가능")
//        }
//        backCameraInput = backCameraDeviceInput
//        if !captureSession!.canAddInput(backCameraInput!) {
//            fatalError("후면 카메라 설치 불가능")
//        }
//        
//        guard frontCamera != nil, let frontCameraDeviceInput = try? AVCaptureDeviceInput(device: frontCamera!) else {
//            fatalError("전면 카메라로 인풋 설정 불가능")
//        }
//        frontCameraInput = frontCameraDeviceInput
//        if !captureSession!.canAddInput(frontCameraInput!) {
//            fatalError("전면 카메라 설치 불가능")
//        }
//        
//        captureSession!.addInput(backCameraInput!)
//        
//    }
//    
//    
//    func addCaptureOutput() {
//        videoOutput = AVCaptureVideoDataOutput()
//        let cameraSampleBufferQueue = DispatchQueue(label: "cameraGlobalQueue", qos: .userInteractive)
//        videoOutput?.setSampleBufferDelegate(self, queue: cameraSampleBufferQueue)
//        
//        if captureSession!.canAddOutput(videoOutput!) {
//            captureSession?.addOutput(videoOutput!)
//        } else {
//            fatalError("아웃풋 설정 불가능")
//        }
//        videoOutput?.connections.first?.videoOrientation = .portrait
//        
//        captureSession?.commitConfiguration()
//        captureSession?.startRunning()
//    }
//    
//    func setPreview() {
//        self.view.layoutIfNeeded()
//        
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
//        previewLayer?.videoGravity = .resizeAspectFill
////        previewLayer?.connection?.videoOrientation = .portrait
//        previewLayer?.frame = cameraView.frame
//        cameraView.layer.insertSublayer(previewLayer!, at: 0)
//    }
//    
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        if !takePicture { return }
//        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
//            return
//        }
//        let ciImage = CIImage(cvImageBuffer: cvBuffer)
//        let uiImage = UIImage(ciImage: ciImage)
//        self.takePicture = false
//        self.captureSession?.stopRunning()
////        DispatchQueue.main.async {
////            guard let pictureVC = self.storyboard?.instantiateViewController(withIdentifier: <#T##String#>) else {
////                return
////            }
////            pictureVC.picture =
////            self.present(pictureVC, animated: false, completion: nil)
////        }
//    }
//}
