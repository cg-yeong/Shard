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
        plateView.snp.remakeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        plateView.addSubview(firstLabel)
        firstLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        plateView.addSubview(itemPlateView)
        itemPlateView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(244)
            $0.leading.equalToSuperview().offset(35)
        }
        
        itemPlateView.addSubview(categoryArticle)
        categoryArticle.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(36)
        }
        
        itemPlateView.addSubview(bottomMenuView)
        bottomMenuView.snp.remakeConstraints {
            $0.bottom.equalTo(itemPlateView.safeAreaInsets.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(36)
            $0.width.equalToSuperview().offset(-40)
        }
        
        itemPlateView.addSubview(itemCollectionView)
        itemCollectionView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(bottomMenuView.snp.top).offset(-15)
            $0.width.equalToSuperview()
            $0.top.equalTo(categoryArticle.snp.bottom).offset(4)
        }
        
        
        print(viewModel.itemCategory.first ?? "")
        print(viewModel.items["combo"]?.first! ?? ItemModel(name: "empty", price: 999))
        
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
    }
    
}
