//
//  BNRHypnosisView.swift
//  ChapterNo4
//
//  Created by Raza Master on 1/3/15.
//  Copyright (c) 2015 raza. All rights reserved.
//

import UIKit


class BNRHypnosisView: UIView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        //All BNRHyponosisView starts with a clear background Color
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        var bounds = self.bounds
        
        //figure out the center of the bounds rectangle
        var center = CGPoint()
        center.x = (bounds.origin.x + bounds.size.width) / 2.0
        center.y = (bounds.origin.y + bounds.size.height) / 2.0
        
        /*//The circle will be the largest that will fit in the view
        var radius:CGFloat = hypot(bounds.size.width, bounds.size.height)/4.0
        */
        
        var path = UIBezierPath()
        
        /*//Add an arc to the path at center, with radius of radius,
        //from 0 to 2*PI randian (a circle)
        var startAngle:CGFloat = 0.0
        path.addArcWithCenter(center, radius: radius, startAngle: startAngle, endAngle: Float(M_PI)*2.0, clockwise: true)
        */
        
        var maxRadius = hypot(bounds.size.width, bounds.size.height)/2.0
        
        for(var currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20){
            path.moveToPoint(CGPointMake(center.x + currentRadius, center.y))
            
            var startAngle:CGFloat = 0.0
            var endAngle:CGFloat = CGFloat(M_PI) * CGFloat(2.0)
            
            path.addArcWithCenter(center, radius: currentRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true
            )
            
        }
        
        ///Congigure line width to 10 points
        path.lineWidth = 10
        
        //Configure the drawing color to light gray
        UIColor.lightGrayColor().setStroke()
        
        //draw the line
        path.stroke()
        
        // --- END CHAPTER # 4 //
        
        // CHALLENGES
        
        var logoImage:UIImage = UIImage(named: "logo")!
        var someRect = CGRectMake((bounds.size.width + logoImage.size.width) / 8.0, (bounds.size.height + logoImage.size.height) / 8.0, bounds.size.width/2.0, bounds.size.height/2.0)
        
        
        var currentContext = UIGraphicsGetCurrentContext()
        CGContextSaveGState(currentContext)
        
        var TriPath = UIBezierPath()
        TriPath.moveToPoint(CGPointMake(logoImage.size.width/2.0, someRect.origin.y))
        TriPath.addLineToPoint(CGPointMake(someRect.origin.x, someRect.size.height + someRect.origin.y))
        TriPath.addLineToPoint(CGPointMake(someRect.origin.x + someRect.size.width, someRect.size.height + someRect.origin.y))
        TriPath.addLineToPoint((CGPointMake(logoImage.size.width/2.0, someRect.origin.y)))
        
        //TriPath.stroke()
        TriPath.addClip()
        
        let locations:[CGFloat] = [0.0, 1.0]
        let components:[CGFloat] = [ 0.0, 1.0, 0.0, 1.0, // Start color: green
            1.0, 1.0, 0.0, 1.0] // End color: yellow
        
        var colorspace = CGColorSpaceCreateDeviceRGB()
        var gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2)
        
        //Draw the Gradient
        CGContextDrawLinearGradient(currentContext, gradient, CGPointMake(logoImage.size.width/2.0, someRect.origin.y),  CGPointMake(logoImage.size.width/2.0, someRect.origin.y + someRect.size.height), 0)
        
        CGContextRestoreGState(currentContext)
        
        currentContext = UIGraphicsGetCurrentContext()
        //Shadow
        CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3)
        
        //Creating Img
        logoImage.drawInRect(someRect)
        
        //CGContextRestoreGState(currentContext)
        
    }
    
    
}