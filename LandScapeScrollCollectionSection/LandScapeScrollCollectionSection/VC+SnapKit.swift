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
        plateView.addSubview(itemPlateView)
        itemPlateView.addSubview(categoryArticle)
        itemPlateView.addSubview(bottomMenuView)
        itemPlateView.addSubview(itemCollectionView)
        itemPlateView.addSubview(pageArticle)
        
        setConstraint()
    }
    
    func setConstraint() {
        plateView.snp.remakeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        firstLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        itemPlateView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(203)
            $0.leading.equalToSuperview().offset(35)
        }
        
        categoryArticle.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(36)
        }
        
        bottomMenuView.snp.remakeConstraints {
            $0.bottom.equalTo(itemPlateView.safeAreaInsets.bottom).offset(-20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(36)
            $0.width.equalToSuperview().offset(-40)
        }
        
        itemCollectionView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(bottomMenuView.snp.top).offset(-15)
            
            $0.top.equalTo(categoryArticle.snp.bottom).offset(4)
        }
        
        viewModel.itemCategory.forEach { category in
            let btn = UIButton()
            btn.isUserInteractionEnabled = true
            btn.setTitle(category, for: .normal)
            btn.addTarget(self, action: #selector(mngStackBtn(_:)), for: .touchUpInside)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
            btn.titleLabel?.sizeToFit()
            
            categoryStack.addArrangedSubview(btn)
            btn.snp.remakeConstraints { make in
                make.height.equalToSuperview()
                make.width.equalTo(btn.titleLabel!.snp.width).offset(10)
            }
        }
        
        pageArticle.snp.remakeConstraints {
            $0.bottom.equalTo(bottomMenuView.snp.top)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.top.equalTo(itemCollectionView.snp.bottom)
        }
    }
}
