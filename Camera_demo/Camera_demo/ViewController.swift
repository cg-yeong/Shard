//
//  ViewController.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/16.
//

import UIKit
import AVFoundation
import Combine

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var cameraView: UIView!
    var captureSession: AVCaptureSession?
    var backCamera: AVCaptureDevice?
    var backCameraInput: AVCaptureInput?
    var frontCamera: AVCaptureDevice?
    var frontCameraInput: AVCaptureInput?
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    var videoOutput: AVCaptureVideoDataOutput?
    
    var takePicture = false
    var isBackCamera = true
    
    var btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        askCameraAuthorizationStatus()
        // Do any additional setup after loading the view.
        setCaptureSession()
        setPreview()
        setOutput()
    }

    func setCaptureSession() {
        captureSession = AVCaptureSession()
        guard let captureSession = captureSession else {
            return
        }

        captureSession.beginConfiguration()
        
        if captureSession.canSetSessionPreset(.photo) {
            captureSession.sessionPreset = .photo
        }
        
        addInputCaptureDevice()
    }
    
    func addInputCaptureDevice() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            backCamera = device
        } else {
            fatalError("후면 카메라 X")
        }
        
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            frontCamera = device
        } else {
            fatalError("전면 카메라 X")
        }
        
        guard backCamera != nil, let backCameraDeviceInput = try? AVCaptureDeviceInput(device: backCamera!) else {
            fatalError("후면 카메라로 인풋 설정 불가능")
        }
        backCameraInput = backCameraDeviceInput
        if !captureSession!.canAddInput(backCameraInput!) {
            fatalError("후면 카메라 설치 불가능")
        }
        
        guard frontCamera != nil, let frontCameraDeviceInput = try? AVCaptureDeviceInput(device: frontCamera!) else {
            fatalError("전면 카메라로 인풋 설정 불가능")
        }
        frontCameraInput = frontCameraDeviceInput
        if !captureSession!.canAddInput(frontCameraInput!) {
            fatalError("전면 카메라 설치 불가능")
        }
        
        captureSession?.addInput(backCameraInput!)
        
    }
    
    func setPreview() {
        self.view.layoutIfNeeded()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.videoGravity = .resizeAspectFill
//        previewLayer?.connection?.videoOrientation = .portrait
        previewLayer?.frame = cameraView.frame
        cameraView.layer.insertSublayer(previewLayer!, at: 0)
    }
    
    func setOutput() {
        videoOutput = AVCaptureVideoDataOutput()
        let cameraSampleBufferQueue = DispatchQueue(label: "cameraGlobalQueue", qos: .userInteractive)
        videoOutput?.setSampleBufferDelegate(self, queue: cameraSampleBufferQueue)
        
        if captureSession!.canAddOutput(videoOutput!) {
            captureSession?.addOutput(videoOutput!)
        } else {
            fatalError("아웃풋 설정 불가능")
        }
        videoOutput?.connections.first?.videoOrientation = .portrait
        
        captureSession?.commitConfiguration()
        captureSession?.startRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if !takePicture { return }
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        let ciImage = CIImage(cvImageBuffer: cvBuffer)
        let uiImage = UIImage(ciImage: ciImage)
        self.takePicture = false
        self.captureSession?.stopRunning()
//        DispatchQueue.main.async {
//            guard let pictureVC = self.storyboard?.instantiateViewController(withIdentifier: <#T##String#>) else {
//                return
//            }
//            pictureVC.picture =
//            self.present(pictureVC, animated: false, completion: nil)
//        }
    }
    
    func askCameraAuthorizationStatus() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { grant in
                if !grant {
                    print("허용 안됨 카메라")
                }
            }
        case .denied:
            let permissionAlert = UIAlertController(title: "권한 필요", message: "카메라 권한이 필요합니다 허용해주세요.", preferredStyle: .alert)
            let openSetting = UIAlertAction(title: "확인", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            permissionAlert.addAction(openSetting)
            
            self.present(permissionAlert, animated: true, completion: nil)
        case .restricted:
            let permissionAlert = UIAlertController(title: "권한 필요", message: "카메라 권한이 필요합니다 허용해주세요.", preferredStyle: .alert)
            let openSetting = UIAlertAction(title: "확인", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            permissionAlert.addAction(openSetting)
            
            self.present(permissionAlert, animated: true, completion: nil)
        case .authorized:
            return
        @unknown default:
            fatalError()
        }
    }
    
}

