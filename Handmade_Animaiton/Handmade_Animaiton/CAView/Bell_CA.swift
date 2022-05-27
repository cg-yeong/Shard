//
//  Bell_CA.swift
//  Handmade_Animaiton
//
//  Created by root0 on 2022/05/27.
//

import Foundation
import UIKit

class Bell_CA: UIView {
    
    var startPoint: CGPoint = CGPoint(x: 50, y: 150)
    
    override func draw(_ rect: CGRect) {
        
        startPath()
    }
    
    
    func startPath() {
        let bell = CAShapeLayer()
        let path = UIBezierPath()
        
//        path.move(to: startPoint)
        path.addArc(withCenter: CGPoint(x: 0, y: 125), radius: 60, startAngle: .pi / 6, endAngle: -.pi / 6, clockwise: false)
        print(path.currentPoint)
        path.addArc(withCenter: CGPoint(x: path.currentPoint.x + 50, y: path.currentPoint.y), radius: 47, startAngle: .pi, endAngle: .pi * 2, clockwise: true)
        path.addArc(withCenter: CGPoint(x: 200, y: 125), radius: 60, startAngle: .pi * 7 / 6, endAngle: .pi * 5 / 6, clockwise: false)
        
        
        
        
        
        
        
        bell.fillMode = .forwards
        bell.fillColor = UIColor.clear.cgColor
        bell.strokeColor = UIColor.black.cgColor
        bell.lineWidth = 3
        
        bell.path = path.cgPath
        self.layer.addSublayer(bell)
        
        
    }
}
