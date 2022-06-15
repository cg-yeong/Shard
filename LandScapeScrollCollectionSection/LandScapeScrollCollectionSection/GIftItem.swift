//
//  GIftItem.swift
//  LandScapeScrollCollectionSection
//
//  Created by root0 on 2022/06/09.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class GiftItem: UICollectionViewCell {
    
    static let identifier = description()
    
    var model: mockItemModel?
    
    lazy var backView: UIView = .init().then {
        $0.backgroundColor = .black
    }
    
    lazy var itemLabel: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.backgroundColor = .cyan
        $0.textColor = .white
        $0.sizeToFit()
    }
    
    lazy var pricePart: UIView = UIView().then {
        $0.addSubview(partStackView)
        
        partStackView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    lazy var partStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.addArrangedSubview(temIcon)
        $0.addArrangedSubview(itemPrice)
        $0.spacing = 2
        
        temIcon.snp.remakeConstraints { make in
            make.width.height.equalTo(18)
        }
        itemPrice.snp.remakeConstraints { make in
            make.height.equalTo(18)
            
        }
    }
    lazy var itemPrice: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = .white
        $0.sizeToFit()
    }
    
    lazy var itemImg = UIImageView()
    lazy var temIcon: UIImageView = UIImageView(image: UIImage(named: "icMoonS"))
    
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
        addSubview(backView)
        
//        backView.addSubview(itemLabel)
        backView.addSubview(itemImg)
        backView.addSubview(pricePart)
        setConstraint()
    }
    
    func setConstraint() {
        
        backView.snp.remakeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        itemImg.snp.remakeConstraints {
            $0.width.height.equalTo(70)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        pricePart.snp.remakeConstraints {
            $0.height.equalTo(22)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(itemImg.snp.bottom)
        }
//        itemLabel.snp.remakeConstraints { item in
//            item.width.height.equalTo(70)
//            item.centerX.equalToSuperview()
//            item.top.equalToSuperview()
//        }
        
    }
    
    func setConfig(model: mockItemModel) {
        self.model = model
        setupUI()
        
        itemLabel.text = "\(model.name)"
        itemPrice.text = "\(model.price)"
    }
    func setConfig_Dal(model: ItemModel) {
        setupUI()
        
        itemImg.sd_setImage(with: URL(string: model.thumbs))
        itemPrice.text = "\(model.cost)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemLabel.text = nil
        itemPrice.text = nil
    }
}
