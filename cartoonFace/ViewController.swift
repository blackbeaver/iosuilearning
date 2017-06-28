//
//  ViewController.swift
//  cartoonFace
//
//  Created by JiaYanwei on 6/21/17.
//  Copyright © 2017 JiaYanwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var faceView: RoundFace!
    private var expression = FacialExpression(eyes: .closed, mouth: .smile) {
        didSet {
            updateUI()
        }
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

