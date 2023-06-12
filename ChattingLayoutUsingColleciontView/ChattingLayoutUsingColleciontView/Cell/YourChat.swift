//
//  MyChat.swift
//  ChattingLayoutUsingColleciontView
//
//  Created by root0 on 2023/06/09.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class YourChat: UICollectionViewCell {
    
    static let identifier = "YourChat"
    
    let container = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let profileView = UIView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 24.0
        $0.clipsToBounds = true
    }
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.tintColor = .systemPink
        $0.backgroundColor = .white
    }
    
    let name = UILabel().then {
        $0.text = "Avri Roel Downey"
        $0.textColor = UIColor(red: 149/255.0, green: 104/255.0, blue: 0, alpha: 1)
        $0.font = .systemFont(ofSize: 13, weight: .medium)
    }
    
    let bubble = UIView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 20.0
        $0.clipsToBounds = true
    }
    
    let chat = UILabel().then {
        $0.text = "Do you want to go with me?"
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textColor = UIColor(red: 32/255.0, green: 32/255.0, blue: 32/255.0, alpha: 1)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        var newFrame = layoutAttributes.frame
        
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        
        return layoutAttributes
    }
    
    func addComponents() {
        contentView.addSubview(container)
        
        container.addSubview(profileView)
        container.addSubview(name)
        container.addSubview(bubble)
        profileView.addSubview(profileImage)
        bubble.addSubview(chat)
    }
    
    func setConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        container.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        profileView.snp.makeConstraints {
            $0.size.equalTo(42)
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        profileImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        name.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.leading.equalTo(profileView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview()
            $0.height.equalTo(19)
        }
        
        bubble.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(4)
            $0.leading.equalTo(name.snp.leading)
            $0.bottom.equalToSuperview()
//            $0.height.greaterThanOrEqualTo(37)
            $0.trailing.equalToSuperview().offset(-73)
        }
        
        chat.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func scrollingProfileView(offset: CGFloat) {
        let update4 = max(0, min(contentView.frame.size.height - profileView.frame.size.height, offset))
        
        profileView.snp.updateConstraints {
            $0.top.equalToSuperview().offset(update4)
        }
    }
    
    func bind(with: R.MemberDummyChat, isSameWithPrev: Bool = false) {
        profileImage.kf.setImage(with: URL(string: with.photo))
        name.text = with.name
        chat.text = with.chat
        
        let hiddenLayout = { [weak self] in
            guard let self = self else { return }
            self.profileView.isHidden = true
            self.name.isHidden = true
            self.bubble.snp.updateConstraints {
                $0.top.equalTo(self.name.snp.bottom).offset(-21)
            }
        }
        
        let showLayout = { [weak self] in
            guard let self = self else { return }
            self.profileView.isHidden = false
            self.name.isHidden = false
            self.bubble.snp.updateConstraints {
                $0.top.equalTo(self.name.snp.bottom).offset(4)
            }
            
        }
        
//        _ = isSameWithPrev ? hiddenLayout() : showLayout()
        
    }
    
    func translateYProfileView(distant: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.profileView.transform = CGAffineTransform(translationX: 0, y: distant)
        }
    }
}
