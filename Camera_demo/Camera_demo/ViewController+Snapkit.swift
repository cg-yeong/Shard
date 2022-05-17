//
//  ViewController+Snapkit.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/17.
//

import Foundation
import SnapKit

extension ViewController {
    
    func addLazyView() {
        
        self.view.addSubview(cameraView)
        cameraView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaInsets)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        self.view.addSubview(inputMenuView)
        self.inputMenuView.addSubview(startBtn)
        inputMenuView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.view.safeAreaInsets)
            make.height.equalTo(100)
        }
        startBtn.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.center.equalToSuperview()
        }
        
        self.inputMenuView.addSubview(swapCam)
        swapCam.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
            $0.centerY.equalTo(inputMenuView)
            $0.trailing.equalToSuperview().offset(-25)
        }
    }
}
