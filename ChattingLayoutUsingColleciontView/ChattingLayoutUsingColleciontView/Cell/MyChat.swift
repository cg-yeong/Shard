//
//  MyChat.swift
//  ChattingLayoutUsingColleciontView
//
//  Created by root0 on 2023/06/09.
//

import UIKit
import SnapKit
import Then

class MyChat: UICollectionViewCell {
    
    static let identifier = "MyChat"
    
    let bubble = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        
        return layoutAttributes
    }
}
