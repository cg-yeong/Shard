//
//  publicExample_CAShapeLayer.swift
//  Handmade_Animaiton
//
//  Created by root0 on 2022/05/27.
//

import Foundation
import UIKit

func ex_1() -> CALayer {
    let width: CGFloat = 320
    let height: CGFloat = 320
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    
    
    let path = CGMutablePath()
    
    stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 6).forEach { angle in
        var transform = CGAffineTransform(rotationAngle: angle)
            .concatenating(CGAffineTransform(translationX: width / 2, y: height / 2))
        let petal = CGPath(ellipseIn: CGRect(x: -20, y: 0, width: 40, height: 100), transform: &transform)
        
        path.addPath(petal)
    }
    
    shapeLayer.path = path
    shapeLayer.strokeColor = UIColor.red.cgColor
    shapeLayer.fillColor = UIColor.yellow.cgColor
    shapeLayer.fillRule = .evenOdd
    
    return shapeLayer
}
