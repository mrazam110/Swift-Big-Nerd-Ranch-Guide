//
//  BNRDetailViewController.swift
//  chap10
//
//  Created by PanaCloud on 7/19/14.
//  Copyright (c) 2014 PanaCloud. All rights reserved.
//

import UIKit

class BNRDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var serialNumberfield: UITextField!
    @IBOutlet var nameField: UITextField!
    
    @IBOutlet var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func takePicture(sender: AnyObject) {
        
        //If the device has a camera, take a picture, otherwise,
        //just pick from photo library
    
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }else{
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePicker.delegate = self
        
        //Place image picker on the Screen
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var item = BNRItem()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.nameField.text = item.itemName
        self.serialNumberfield.text = item.serialNumber
        self.valueField.text = "\(item.valueInDollars)"
        self.navigationItem.title = item.itemName
        
        //We need an NSDateFormatter that will turn a date into a simple date string
        var dateFormatter:NSDateFormatter!
        if(dateFormatter == nil){
            dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        }
        
        //use filtered NSdate object to set dateLabel contents
        self.dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
        
        var imageKey = self.item.itemKey
        
        //Get the image for ites image key from the image store
        var imageToDisplay:UIImage = BNRImageStore.sharedStore.imageForKey(imageKey)
        
        //Use that image to put on the screen in the image view
        self.imageView.image = imageToDisplay
        
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
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        
        //Get picked image from info dictionary
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        // Store the image in the BNRImageStore for this key
        BNRImageStore.sharedStore.setImage(image, forKey: self.item.itemKey)
        
        //Put that image onto the screen in our image view
        self.imageView.image = image
        
        imagePicker.allowsEditing = true
        
        //Take image picker off the screen
        // you must call this dismiss method
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        self.view.endEditing(true)
    }
}
