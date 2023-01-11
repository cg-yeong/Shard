//
//  HaveDisabledToastButton.swift
//  HaveDisabledToastButton
//
//  Created by root0 on 2023/01/11.
//

import UIKit
import Toast

/**
 비활성화후 클릭시에 Toast 띄우기
 
 - Parameter:
    - isEnabledUI: Toast 띄울 버튼 isHidden On <-> Off 하기 위한 Boolean 값
    - disablePhrase: Toast 문구
 
 ```
 targetView.isEnabledUI = !targetView.isEnabledUI
 disablePhrase = "비활성화 된 버튼입니다"
 ```
 */
class HaveDisabledToastButton: UIButton {
    
    lazy var btnWhenDisabled: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("ㅂㅎㅅㅎ", for: .normal)
        btn.setTitleColor(.brown, for: .normal)
        btn.addTarget(self, action: #selector(showToastWhenBtnDisabled), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    @IBInspectable
    var disablePhrase: String = ""
    
    private var toastPhrase: String {
        get {
            return disablePhrase
        }
    }
    
    var isEnabledUI: Bool = true {
        didSet {
            btnWhenDisabled.isHidden = isEnabledUI
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addComponent()
    }
    
    func addComponent() {
        btnWhenDisabled.frame = self.bounds
        btnWhenDisabled.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(btnWhenDisabled)
    }
    
    @objc func showToastWhenBtnDisabled() {
        showToast(toastPhrase)
    }
    
    func showToast(_ msg: String) {
        
        print(msg)
        var style = ToastStyle()
        style.titleAlignment = .center
        style.messageAlignment = .center
        style.horizontalPadding = 20
        style.messageColor = .white
        style.backgroundColor = .black
        
        guard let vc = UIApplication.topViewController() else {
             return
        }
        
        vc.view.hideAllToasts()
        vc.view.clearToastQueue()
        print(msg)
        self.makeToast(msg,
                       duration: 2.0,
                       position: .center,
                       style: style)
        
    }
    
}
