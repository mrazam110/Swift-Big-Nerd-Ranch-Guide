//
//  BNRDetailViewController.swift
//  UINavigationController10
//
//  Created by Raza Master on 1/3/15.
//  Copyright (c) 2015 raza. All rights reserved.
//

import UIKit

class BNRDetailViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var serialNumberfield: UITextField!
    @IBOutlet var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    var item = BNRItem()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameField.text = item.itemName
        self.serialNumberfield.text = item.serialNumber
        self.valueField.text = "\(item.valueInDollars)"
        self.navigationItem.title = item.itemName
        
        println(item)
        //We need an NSDateFormatter that will turn a date into a simple date string
        var dateFormatter:NSDateFormatter!
        if(dateFormatter == nil){
            dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        }
        
        //use filtered NSdate object to set dateLabel contents
        self.dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        //Clear first responder
        self.view.endEditing(true)
        
        //"Save" changes to item
        var item = self.item
        item.itemName = self.nameField.text
        item.serialNumber = self.serialNumberfield.text
        item.valueInDollars = self.valueField.text.toInt()!
        
    }
    
}