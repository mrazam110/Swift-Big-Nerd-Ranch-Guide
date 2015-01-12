//
//  BNRDrawView.swift
//  chap12
//
//  Created by PanaCloud on 7/22/14.
//  Copyright (c) 2014 PanaCloud. All rights reserved.
//

import UIKit

class BNRDrawView: UIView, UIGestureRecognizerDelegate {
    
    var moveRecognizer:UIPanGestureRecognizer?
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
        
        var doubleTapRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        self.addGestureRecognizer(doubleTapRecognizer)
        
        var tapRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tap:")
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        self.addGestureRecognizer(tapRecognizer)
        
        var pressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.addGestureRecognizer(pressRecognizer)
        
        self.moveRecognizer = UIPanGestureRecognizer(target: self, action: "moveLine:")
        self.moveRecognizer!.delegate = self
        self.moveRecognizer!.cancelsTouchesInView = false
        self.addGestureRecognizer(self.moveRecognizer!)
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer!, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer!) -> Bool {
        if(gestureRecognizer == self.moveRecognizer){
            return true
        }
        return false
    }
    
    func moveLine(gr: UIPanGestureRecognizer){
        println("Pan Gesture Recognizer")
        
        //If we have not selected a line, we do not do anything here
        if((self.selectedLine) == nil){
            return
        }
        //When the pan recognizer changes its position...
        if(gr.state == UIGestureRecognizerState.Changed){
            //How far has the pan moved?
            var translation:CGPoint = gr.translationInView(self)
            
            //Add the translation to the current beginning and end points of the line
            var begin:CGPoint = self.selectedLine!.begin
            var end:CGPoint = self.selectedLine!.end
            begin.x += translation.x
            begin.y += translation.y
            end.x += translation.x
            end.y += translation.y
            
            //Set the new beginning and end points of the line
            self.selectedLine!.begin = begin
            self.selectedLine!.end = end
        
            //Redraw the screen
            self.setNeedsDisplay()
            gr.setTranslation(CGPointZero, inView: self)
        }
    }
    
    func longPress(gr: UIGestureRecognizer){
        println("Long Gesture")
        if(gr.state == UIGestureRecognizerState.Began){
            var point:CGPoint = gr.locationInView(self)
            self.selectedLine = self.lineAtPoint(point)
            
            if((self.selectedLine) != nil){
                self.linesInProgress.removeAllObjects()
            }
        }else if(gr.state == UIGestureRecognizerState.Ended){
            self.selectedLine = nil
        }
        self.setNeedsDisplay()
    }
    
    func tap(gr: UIGestureRecognizer){
        println("Recognized Tap")
        
        var point:CGPoint = gr.locationInView(self)
        self.selectedLine = self.lineAtPoint(point)
        
        if((self.selectedLine) != nil){
            //Make ourselves the target of menu item action messages
            self.becomeFirstResponder()
            
            //Grab the menu controller
            var menu:UIMenuController = UIMenuController.sharedMenuController()
            
            //Create a new "Delete" UIMenuItem
            var deleteItem:UIMenuItem = UIMenuItem(title: "Delete", action: "deleteLine:")
            menu.menuItems = [deleteItem]
            
            //tell the menu where it should come from and show it
            menu.setTargetRect(CGRectMake(point.x, point.y, 2, 2), inView: self)
            menu.setMenuVisible(true, animated: true)
            print("h")
        }else{
            //Hide the menu if no line is selected
            UIMenuController.sharedMenuController().setMenuVisible(false, animated: true)
        }
        
        //Redraw everything
        self.setNeedsDisplay()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    func deleteLine(sender: AnyObject){
        print("Remove?")
        
        //Remove the selected line from the list of finished:ines
        self.finishedLines.removeObject(self.selectedLine!)
        
        //Redraw everything
        self.setNeedsDisplay()
        
    }
    
    func doubleTap(gr:UIGestureRecognizer){
        println("Recognized Double Tap")
        self.linesInProgress.removeAllObjects()
        self.finishedLines.removeAllObjects()
        self.setNeedsDisplay()
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
        
        if((self.selectedLine) != nil){
            UIColor.greenColor().set()
            self.strokeLine(self.selectedLine!)
        }
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var t: AnyObject! = touches.anyObject()
        
        println("Touch Began")
        //Get location of the touch in views coordinate system
        /*var location = t.locationInView(self)
        self.currentLine = BNRLine()
        self.currentLine!.begin = location
        self.currentLine!.end = location
        println(location)
        */
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
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
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
    
    override func touchesCancelled(touches: NSSet, withEvent event: UIEvent) {
        //Let's put in a log statement to see the order of events
        println("Touch Cancelled")
        var t: AnyObject! = touches.anyObject()
        
        for t in touches.allObjects {
            var key = NSValue(nonretainedObject: t)
            self.linesInProgress.removeObjectForKey(key)
        }
        self.setNeedsDisplay()
    }
    
    func lineAtPoint(p:CGPoint)->BNRLine?{
        //Fine a line close to p
        for line in self.finishedLines {
            var l = line as BNRLine
            var start:CGPoint = l.begin as CGPoint
            var end:CGPoint = l.end as CGPoint
            
            //Check a few points on the line
            for(var t:CGFloat = 0.0; t <= 1.0; t+=0.05){
                var x:CGFloat = start.x + t * (end.x - start.x)
                var y:CGFloat = start.y + t * (end.y - start.y)
                
                //If the tapped point is within 20 points, lets return this line
                if(hypot(x - p.x, y - p.y) < 20.0){
                    return l
                }
            }
        }
        //If nothing is close enough to the tapped point, then we did not select a line
        return nil
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
