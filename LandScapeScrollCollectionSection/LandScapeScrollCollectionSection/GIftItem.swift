//
//  GIftItem.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/09.
//

import Foundation
import UIKit
import SnapKit

class GiftItem: UICollectionViewCell {
    
    static let identifier = description()
    
    var model: ItemModel?
    
    lazy var itemLabel: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.backgroundColor = .cyan
        $0.textColor = .white
        $0.sizeToFit()
    }
    
    lazy var itemPrice: UILabel = UILabel().then {
        $0.numberOfLines = 1
        $0.backgroundColor = .brown
        $0.textColor = .white
        $0.textAlignment = .center
        $0.sizeToFit()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupUI() {
        backgroundColor = .lightGray
        addSubview(itemLabel)
        addSubview(itemPrice)
        setConstraint()
    }
    
    func setConstraint() {
        itemLabel.snp.remakeConstraints { item in
            item.width.height.equalTo(70)
            item.centerX.equalToSuperview()
            item.top.equalToSuperview()
        }
        
        itemPrice.snp.remakeConstraints {
//            $0.width.equalTo(27)
            $0.height.equalTo(18)
            $0.top.equalTo(itemLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setConfig(model: ItemModel) {
        self.model = model
        setupUI()
        
        itemLabel.text = "\(model.name)"
        itemPrice.text = "\(model.price)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemLabel.text = nil
        itemPrice.text = nil
    }
}
