//
//  ViewController+Snapkit.swift
//  Camera_demo
//
//  Created by root0 on 2022/05/17.
//

import Foundation
import SnapKit

extension CameraVC {
    
    func addLazyView() {
        
        self.view.addSubview(cameraView)
        cameraView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(topMenuView)
        topMenuView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.view.addSubview(bottomMenuView)
        bottomMenuView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        self.bottomMenuView.addSubview(galleryPreview)
        galleryPreview.snp.makeConstraints { make in
            make.centerY.equalTo(bottomMenuView)
            make.width.height.equalTo(50)
            make.leading.equalToSuperview().offset(25)
        }
        self.bottomMenuView.addSubview(shutBtn)
        shutBtn.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.center.equalToSuperview()
        }
        
        self.bottomMenuView.addSubview(swapCam)
        swapCam.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(50)
            $0.centerY.equalTo(bottomMenuView)
            $0.trailing.equalToSuperview().offset(-25)
        }
    }
}
