//
//  CameraVC.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/19.
//

import Foundation
import UIKit
import Combine

class CameraVC: UIViewController {
    
    lazy var cameraView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var topMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var muteBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "sound"), for: .normal)
        btn.setImage(UIImage(named: "mute"), for: .selected)
        btn.contentMode = .center
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 25
        return btn
    }()
    
    lazy var flashBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "flashOff"), for: .normal)
        btn.setImage(UIImage(named: "flashOn"), for: .selected)
        btn.contentMode = .center
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 25
        return btn
    }()
    
    lazy var bottomMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var galleryPreview: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var preImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var shutBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "circle"), for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        return btn
    }()
    
    lazy var swapCam: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "flip"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 9)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    var cBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Permission.sharedInstance.request(.Camera)
        // Do any additional setup after loading the view.
        addLazyView()
        
        observeTaps()
    }
    
    private func observeTaps() {
        swapCam
            .publisher(for: .touchUpInside)
            .sink { _ in
                print("Swap Camera Tapped")
            }
            .store(in: &cBag)
    }
    
    
}
//<a target="_blank" href="https://icons8.com/icon/16414/flash-auto">Flash Auto</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>
//icon by Icons8

