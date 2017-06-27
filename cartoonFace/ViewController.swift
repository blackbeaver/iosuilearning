//
//  ViewController.swift
//  cartoonFace
//
//  Created by JiaYanwei on 6/21/17.
//  Copyright © 2017 JiaYanwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private func updateUI(){
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squiting:
            faceView?.eyesopen = false
        }
        faceView?.emothionFactor = emotionFactors[expression.mouth] ?? 0.0
    }
    
    private let emotionFactors = [

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

