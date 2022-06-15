//
//  VC+SnapKit.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/09.
//

import Foundation
import SnapKit

extension ViewController {
    
    func addSnapView() {
        
        view.addSubview(plateView)
        plateView.addSubview(firstLabel)
        
        
        plateView.snp.remakeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        firstLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(presentView)
        presentView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}
