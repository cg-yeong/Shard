//
//  MirrorButton.swift
//  practiveUIPageViewController
//
//  Created by root0 on 2023/05/03.
//

import UIKit
import CoreMotion
import RxSwift
import RxCocoa
import AVFoundation
import SnapKit
import Then

class MotionManager {
    private let motionManager = CMMotionManager()
    public var x = BehaviorSubject<Double>(value: 0.0)
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else { return }
            self?.x.onNext(motion.roll)
        }
    }
}

class MirrorButton: UIView {
    private var tap1 = BehaviorRelay<Bool>(value: false)
    private var gradientAngle = BehaviorRelay<Double>(value: 0.0)
//    private var motion = MotionManager()
    
    var plate = CameraPreview()
    var btn = UIButton().then {
        $0.setTitle("OPEN", for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(plate)
        self.addSubview(btn)
        
        plate.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        btn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public protocol CameraViewDelegate {
    func cameraAccessGranted()
    func cameraAccessDenied()
    func noCameraDetected()
    func cameraSessionStarted()
}
class CameraView: UIView {
    private var delegate: CameraViewDelegate?
    private var cameraType: AVCaptureDevice.DeviceType?
    private var cameraPosition: AVCaptureDevice.Position?
    
    var preview: CameraPreview?
    
    
    public init(delegate: CameraViewDelegate? = nil,
                cameraType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera,
                cameraPosition: AVCaptureDevice.Position = .back) {
        super.init(frame: .zero)
        self.delegate = delegate
        self.cameraType = cameraType
        self.cameraPosition = cameraPosition
        
        self.preview = CameraPreview(delegate: delegate, cameraType: cameraType, cameraPosition: cameraPosition)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class CameraPreview: UIView {
    private var delegate: CameraViewDelegate?
    private var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    init(delegate: CameraViewDelegate? = nil,
         cameraType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera,
         cameraPosition: AVCaptureDevice.Position = .back) {
        super.init(frame: .zero)
        self.delegate = delegate
        var accessAllowed = false
        
        let dBlock = DispatchGroup()
        dBlock.enter()
        
        AVCaptureDevice.requestAccess(for: .video) { flag in
            accessAllowed = flag // 기기 1회 -> 커스텀으로 유도
            dBlock.leave()
        }
        dBlock.wait()
        
        guard accessAllowed else {
            delegate?.cameraAccessDenied()
            return
        }
        delegate?.cameraAccessGranted()
        
        let session = AVCaptureSession()
        session.beginConfiguration()
        let videoDevice = AVCaptureDevice.default(cameraType, for: .video, position: cameraPosition)
        
        guard videoDevice != nil,
              let videoDeivceInput = try? AVCaptureDeviceInput(device: videoDevice!),
              session.canAddInput(videoDeivceInput) else {
            delegate?.noCameraDetected()
            return
        }
        
        session.addInput(videoDeivceInput)
        session.commitConfiguration()
        
        self.captureSession = session
        delegate?.cameraSessionStarted()
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview != nil {
            self.videoPreviewLayer.session = self.captureSession
            self.videoPreviewLayer.videoGravity = .resizeAspect
            self.captureSession?.startRunning()
        } else {
            self.captureSession?.stopRunning()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
