//
//  BNRHypnosisViewController.swift
//  07Chapter
//
//  Created by Raza Master on 1/3/15.
//  Copyright (c) 2015 raza. All rights reserved.
//

import UIKit

class BNRHypnosisViewController: UIViewController, UITextFieldDelegate {

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        //Set the tab bar item's title
        self.tabBarItem.title = "Hypnotize"
        
        //Create a UIImage from a file
        var i = UIImage(named: "Hypno")
        
        //Put that image on the tab bar item
        self.tabBarItem.image = i
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Set the tab bar item's title
        self.tabBarItem.title = "Hypnotize"
        
        //Create a UIImage from a file
        var i = UIImage(named: "Hypno")
        
        //Put that image on the tab bar item
        self.tabBarItem.image = i
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func loadView() {
        let backgroundView = BNRHypnosisView(frame: CGRectMake(0, 0, 320, 568))
        self.view = backgroundView
        
        let textFieldRect = CGRectMake(40, 70, 240, 30)
        let textField = UITextField(frame: textFieldRect)
        
        //Setting the border style on the text field will allow us to see it more easily
        textField.borderStyle = UITextBorderStyle.RoundedRect
        
        textField.placeholder = "Hypnotize me"
        textField.returnKeyType = UIReturnKeyType.Done
        
        textField.delegate = self
        
        backgroundView.addSubview(textField)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        //println(textField.text)
        
        self.drawHypnoticMessage(textField.text)
        
        textField.text = ""
        textField.resignFirstResponder()
        
        return true
    }
    
    func drawHypnoticMessage(message: String) {
        for i in 1..<20 {
            let messageLabel = UILabel()
            
            // Configure the label's colors and text
            messageLabel.backgroundColor = UIColor.clearColor()
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.text = message
            
            // This method resizes the label, which will be relative to the text
            // that it is displaying
            messageLabel.sizeToFit()
            
            // Get a random x value that fits w/i the hypnosis view's width
            let width = UInt32(view.bounds.size.width - messageLabel.bounds.size.width)
            let x = Int(arc4random() % width)
            
            // Get a random y value that fits w/i the hypnosis view's height
            let height = UInt32(view.bounds.size.height - messageLabel.bounds.size.height)
            let y = Int(arc4random() % height)
            
            // Update the label's frame
            messageLabel.frame.origin = CGPointMake(CGFloat(x), CGFloat(y))
            
            // Add label to the hierarchy
            view.addSubview(messageLabel)
            
            // Add the "parallax" effect
            // x-axis
            var motionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
            // y-axis
            motionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
            motionEffect.minimumRelativeValue = -25
            motionEffect.maximumRelativeValue = 25
            messageLabel.addMotionEffect(motionEffect)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}