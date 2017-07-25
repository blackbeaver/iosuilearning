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
    var emotionFactor: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var faceColor: UIColor = UIColor.blue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var scaleFactor: CGFloat = 0.9 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var lineWidth: CGFloat = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var eyesOpen: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    enum sideOfEye {
        case left
        case right
    }
    
    struct ratioOfEyeToHead {
        static let eyeXOffsetToHeadRadius: CGFloat = 0.4
        static let eyeYOffsetToHeadRadius: CGFloat = 3
        static let eyeRadiousToHeadRadius: CGFloat = 0.2
        
        static let mouthYOffsetToHeadRadius: CGFloat = 3
        static let mouthMidXOffsetToHeadRadius: CGFloat = 0.25
        static let mouthMaxXOffsetToHeadRadius: CGFloat = 0.5
        static let mouthHeightToHeadRadius: CGFloat = 3
        
    }
    
    private var centerOfHead: CGPoint {
        return CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }
    
    private var faceRadius: CGFloat {
        return CGFloat(min(self.bounds.maxX, self.bounds.maxY) / 2 * scaleFactor)
    }
    
    
    func pinch(recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed,.ended:
            scaleFactor =  recognizer.scale * scaleFactor
            recognizer.scale = 1
        default:
            break
        }
    }
    
    private func faceBezierPath() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: centerOfHead,
                                radius: faceRadius,
                                startAngle: 0,
                                endAngle: CGFloat.pi * 2,
                                clockwise: false)
        
        path.lineWidth = lineWidth
        return path
        
    }
    
    private func eyeBezierpath(eye: sideOfEye) -> UIBezierPath {
        let eyeY = centerOfHead.y - faceRadius / ratioOfEyeToHead.eyeYOffsetToHeadRadius
        let eyeRadius = faceRadius * ratioOfEyeToHead.eyeRadiousToHeadRadius
        
        func eyeCenter(side: sideOfEye) -> CGPoint {
            let x = centerOfHead.x + ((eye == .left) ? -1 : 1) * faceRadius * ratioOfEyeToHead.eyeXOffsetToHeadRadius
            
            return CGPoint(x: x, y: eyeY)
        }
        
        let path:UIBezierPath
        
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter(side: eye),
                                    radius: eyeRadius,
                                    startAngle: 0,
                                    endAngle: CGFloat.pi * 2,
                                    clockwise: true)
        }else {
            path = UIBezierPath()
            let eyeSPX = eyeCenter(side: eye).x - eyeRadius
            let eyeEPX = eyeCenter(side: eye).x + eyeRadius
            path.move(to: CGPoint(x: eyeSPX, y: eyeY))
            path.addLine(to: CGPoint(x: eyeEPX, y: eyeY))
        }
        path.lineWidth = lineWidth
        
        return path
    }
    
    private func mouthBezierPath() -> UIBezierPath {
        let mouthHeight = faceRadius / ratioOfEyeToHead.mouthHeightToHeadRadius
        let mouthY = centerOfHead.y + faceRadius / ratioOfEyeToHead.mouthYOffsetToHeadRadius
        
        
        
        let mouthP1X = centerOfHead.x - faceRadius * ratioOfEyeToHead.mouthMaxXOffsetToHeadRadius
        let mouthP2X = centerOfHead.x - faceRadius * ratioOfEyeToHead.mouthMidXOffsetToHeadRadius
        let mouthP3X = centerOfHead.x + faceRadius * ratioOfEyeToHead.mouthMidXOffsetToHeadRadius
        let mouthP4X = centerOfHead.x + faceRadius * ratioOfEyeToHead.mouthMaxXOffsetToHeadRadius
        
        let mouthP2P3Y = mouthY + CGFloat(max(-1, min(emotionFactor, 1))) * mouthHeight
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: mouthP1X, y: mouthY))
        path.addCurve(to: CGPoint(x: mouthP4X, y: mouthY),
                      controlPoint1: CGPoint(x: mouthP2X, y: mouthP2P3Y),
                      controlPoint2: CGPoint(x: mouthP3X, y: mouthP2P3Y))
        path.lineWidth = lineWidth
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        faceColor.set()
        faceBezierPath().stroke()
        eyeBezierpath(eye: .left).stroke()
        eyeBezierpath(eye: .right).stroke()
        mouthBezierPath().stroke()
    }
    
}
