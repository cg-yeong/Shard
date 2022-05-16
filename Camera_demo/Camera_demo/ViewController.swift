//
//  ViewController.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/16.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var captureSession: AVCaptureSession?
    var backCamera: AVCaptureDevice?
    var backCameraInput: AVCaptureInput?
    var frontCamera: AVCaptureDevice?
    var frontCameraInput: AVCaptureInput?
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    var videoOutput: AVCaptureVideoDataOutput?
    
    var takePicture = false
    var isBackCamera = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    
    
}

