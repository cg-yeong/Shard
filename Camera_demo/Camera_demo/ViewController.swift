//
//  ViewController.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/16.
//

import UIKit
import AVFoundation
import SnapKit

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    lazy var cameraView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    
    
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
        Permission.sharedInstance.request(.Camera)
        // Do any additional setup after loading the view.
        addLazyView()
        setCaptureSession()
        setPreview()
        setOutput()
    }

    func addLazyView() {
        
        self.view.addSubview(cameraView)
        cameraView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaInsets)
            make.bottom.equalToSuperview().offset(-100)
        }
        
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
    
    
    
}

