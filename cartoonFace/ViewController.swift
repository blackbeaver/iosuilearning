//
//  ViewController.swift
//  cartoonFace
//
//  Created by JiaYanwei on 6/21/17.
//  Copyright © 2017 JiaYanwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var faceView: RoundFace! {
        didSet {
            let pinchGestureRecognizer = UIPinchGestureRecognizer(
                target: faceView, action: #selector (faceView.pinch(recognizer:))
            )
            faceView.addGestureRecognizer(pinchGestureRecognizer)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(recognizer:))
            )
            faceView.addGestureRecognizer(tapGestureRecognizer)
            
            let swipeUPGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.moreHappiness))
            swipeUPGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUPGestureRecognizer)
            
            let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.lessHappiness))
            swipeDownGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownGestureRecognizer)
        }
    }
    private var expression = FacialExpression(eyes: .closed, mouth: .neutral) {
        didSet {
            updateUI()
        }
    }
    
    
    func moreHappiness()
    {
        expression = expression.happier
    }
    func lessHappiness()
    {
        expression = expression.sadder
    }
    
    
    func tap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            print("\(recognizer.location(in: faceView!))")
            //faceView!.eyesOpen = faceView!.eyesOpen ? false : true
            let eyeState:FacialExpression.Eyes
            if expression.eyes == .open {
                eyeState = .closed
            } else {
                eyeState = .open
            }
            let mouthState = expression.mouth
            expression = FacialExpression(eyes: eyeState, mouth: mouthState)
        }
    }
    
    func pan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed:fallthrough
//            print("\(recognizer.translation(in: faceView).x)")
        case .ended:
            let translation = recognizer.translation(in: faceView)
            print("\(translation.x)")
            //expression = expression.sadder
//            faceView.scaleFactor = -1 * (translation.y - faceView.bounds.midY / (min(faceView.bounds.maxX, faceView.bounds.maxY) / 2))
            recognizer.setTranslation(CGPoint.zero, in: faceView)
        default:
            break
        }
        updateUI()
    }
    
    
    
    private func updateUI(){
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squiting:
            faceView?.eyesOpen = false
        }
        faceView?.emotionFactor = emotionFactors[expression.mouth] ?? 0.0
    }
    
    private let emotionFactors = [FacialExpression.Mouth.grin: 0.5,
                                  .frown: -1.0,
                                  .smile: 1.0,
                                  .neutral: 0.0,
                                  .smirk: -0.5]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

