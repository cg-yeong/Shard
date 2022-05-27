//
//  CAView.swift
//  Handmade_Animaiton
//
//  Created by root0 on 2022/05/27.
//

import Foundation
import UIKit

class CAView: UIView, CAAnimationDelegate {
    
    let circleLayer: CAShapeLayer = CAShapeLayer()
    
    var startAngle: CGFloat = -.pi / 2
    var endAngle: CGFloat = 0
    let values: [CGFloat] = [10, 20, 60, 90]
    var currentIndex: Int = 0
    var myCenter: CGPoint = .zero
    
    let colors: [UIColor] = [.orange, .yellow, .green, .systemPink, .cyan, .systemTeal, .systemIndigo, .purple]
    
    override func draw(_ rect: CGRect) {
        self.myCenter = CGPoint(x: rect.midX, y: rect.midY)
        self.startAnimation()
    }
    
    func startAnimation() {
        let value = values[currentIndex]
        let total = values.reduce(0, +)
        endAngle = (value / total) * .pi * 2
        
        let path = UIBezierPath(arcCenter: myCenter, radius: 60, startAngle: startAngle, endAngle: startAngle + endAngle, clockwise: true)
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = path.cgPath
        sliceLayer.fillColor = nil
        sliceLayer.strokeColor = colors.randomElement()?.cgColor
        sliceLayer.lineWidth = 80
        sliceLayer.strokeEnd = 1
        self.layer.addSublayer( sliceLayer )
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.delegate = self
        sliceLayer.add(animation, forKey: animation.keyPath)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let isFinished = flag
        if isFinished && currentIndex < self.values.count - 1 {
            self.currentIndex += 1
            self.startAngle += endAngle
            self.startAnimation()
        }
    }
}
