//
//  ViewController.swift
//  AnimationTest
//
//  Created by Years on 14/10/21.
//  Copyright (c) 2014年 Years.im. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        let path = UIBezierPath()
        
        path.moveToPoint(animationView.layer.position)
        path.addLineToPoint(CGPointMake(300, 50))
        path.addLineToPoint(CGPointMake(50, 50))
        
        animation.repeatCount = Float(Int.max)
        
        animation.path = path.CGPath
        animation.duration = 5
        animation.delegate = self
 
        animationView.layer.addAnimation(animation, forKey: "testAnimation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: CAAnimation delegate
    override func animationDidStart(anim: CAAnimation!) {
        
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        
    }
    
    // MARK: Actions
    
    @IBAction func startClick(sender: AnyObject) {
        self.resumeLayer(animationView.layer)
    }
    
    @IBAction func stopClick(sender: AnyObject) {
        self.pauseLayer(animationView.layer)
    }
    
    @IBAction func upClick(sender: AnyObject) {
        let layer = animationView.layer
        layer.timeOffset = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.beginTime = CACurrentMediaTime()
        layer.speed += 0.1
    }
    
    @IBAction func downClick(sender: AnyObject) {
        let layer = animationView.layer
        layer.timeOffset = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.beginTime = CACurrentMediaTime()
        layer.speed -= 0.1
        if layer.speed <= 0 {
            layer.speed = 0.1
        }
    }
    
    // MARK: Animation Control
    func pauseLayer(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
    }
    
    func resumeLayer(layer: CALayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        layer.beginTime = timeSincePause
    }

}

