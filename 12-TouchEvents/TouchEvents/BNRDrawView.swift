//
//  BNRDrawView.swift
//  chap12
//
//  Created by PanaCloud on 7/22/14.
//  Copyright (c) 2014 PanaCloud. All rights reserved.
//

import UIKit

class BNRDrawView: UIView, UIGestureRecognizerDelegate {
    
    var finishedLines:NSMutableArray = NSMutableArray()
    //var currentLine:BNRLine?
    var linesInProgress: NSMutableDictionary = NSMutableDictionary()
    var selectedLine:BNRLine?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        
        //finishedLines = NSMutableArray()
        //linesInProgress = NSMutableDictionary()
        
        self.backgroundColor = UIColor.grayColor()
        self.multipleTouchEnabled = true
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func strokeLine(line: BNRLine){
        var bp = UIBezierPath()
        bp.lineWidth = 10
        bp.lineCapStyle = kCGLineCapRound
        
        bp.moveToPoint(line.begin)
        bp.addLineToPoint(line.end)
        bp.stroke()
    }
    
    override func drawRect(rect: CGRect) {
        //Draw finished lines in black
        UIColor.blackColor().set()
        for(var line = 0; line < self.finishedLines.count; line++){
            self.strokeLine(self.finishedLines[line] as BNRLine)
        }
        //If there is a line currently beiing drawn, do it in red
        UIColor.redColor().set()
        for key in self.linesInProgress.allKeys as [NSValue] {
            self.strokeLine(self.linesInProgress[key] as BNRLine)
        }
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var t: AnyObject! = touches.anyObject()
        
        println("Touch Began")
        //Get location of the touch in views coordinate system
        for t in touches.allObjects {
            var location = t.locationInView(self)
            var line = BNRLine()
            line.begin = location
            line.end = location
            
            var key = NSValue(nonretainedObject: t)
            self.linesInProgress[key] = line
        }
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var t: AnyObject! = touches.anyObject()
        
        println("Touch Moved")
        
        for t in touches.allObjects {
            var key = NSValue(nonretainedObject: t)
            var line:BNRLine = self.linesInProgress[key] as BNRLine
            line.end = t.locationInView(self)
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        var t: AnyObject! = touches.anyObject()
        
        println("Touch Ended")
        
        for t in touches.allObjects {
            var key = NSValue(nonretainedObject: t)
            var line:BNRLine = self.linesInProgress[key] as BNRLine
            
            self.finishedLines.addObject(line)
            self.linesInProgress.removeObjectForKey(key)
        }
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        //Let's put in a log statement to see the order of events
        println("Touch Cancelled")
        var t: AnyObject! = touches.anyObject()
        
        for t in touches.allObjects {
            var key = NSValue(nonretainedObject: t)
            self.linesInProgress.removeObjectForKey(key)
        }
        self.setNeedsDisplay()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
