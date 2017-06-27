//
//  RoundFace.swift
//  cartoonFace
//
//  Created by JiaYanwei on 6/21/17.
//  Copyright © 2017 JiaYanwei. All rights reserved.
//

import UIKit


@IBDesignable
class RoundFace: UIView {
    @IBInspectable
    var emotionFactor: Double = 1.0
    
    @IBInspectable
    var faceColor: UIColor = UIColor.blue
    
    @IBInspectable
    var scaleFactor: Double = 0.9
    
    @IBInspectable
    var lineWidth: Double = 5.0
    
    
    enum sideOfEye {
        case left
        case right
    }
    
    struct ratioOfEyeToHead {
        static let eyeXOffsetToHeadRadius: CGFloat = 0.4
        static let eyeYOffsetToHeadRadius: CGFloat = 3
        static let eyeRadiousToHeadRadius: CGFloat = 0.2
        
        static let mouth1ToHeadRadius: CGFloat = 3
        static
    }
    
    private var centerOfHead: CGPoint {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }
    
    private var faceRadius: CGFloat {
        return CGFloat(min(self.bounds.maxX, self.bounds.maxY) / 2 * CGFloat(scaleFactor))
    }
    
    private func faceBezierPath() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: centerOfHead, radius: faceRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        
        path.lineWidth = CGFloat(lineWidth)
        return path
        
    }
    
    private func eyeBezierpath(eye: sideOfEye) -> UIBezierPath {
        func eyeCenter(side: sideOfEye) -> CGPoint {
        }
            let x = centerOfHead.y - faceRadius / ratioOfEyeToHead.eyeYOffsetToHeadRadius
            let y = centerOfHead.x + ((eye == .left) ? -1 : 1) * faceRadius * ratioOfEyeToHead.eyeXOffsetToHeadRadius
            
            return CGPoint(x: x, y: y)
        }
    }
    
    override func draw(_ rect: CGRect) {
        faceColor.set()
        faceBezierPath().stroke()
    }
    
}
