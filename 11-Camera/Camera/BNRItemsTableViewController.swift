//
//  BNRItemsTableViewController.swift
//  Chap8
//
//  Created by PanaCloud on 7/18/14.
//  Copyright (c) 2014 PanaCloud. All rights reserved.
//

import UIKit

class BNRItemsTableViewController: UITableViewController {
    
    var _headerView : UIView! = nil
    
    @IBOutlet var abc: UIButton!
    
    @IBOutlet var headerView : UIView! {
    get {
        if (_headerView != nil) {
            NSBundle.mainBundle().loadNibNamed("dahead", owner: self, options: nil)
        }
        return _headerView
    }
    set {
        _headerView = newValue
        }
    }
    @IBAction func addNewItem(sender: AnyObject) {
        
        let newItem = BNRItemStore.sharedStore.createItem()
        
        // Figure out where that item is in the array
        var lastRow: Int = 0
        for i in 0..<BNRItemStore.sharedStore.allItems.count {
            if BNRItemStore.sharedStore.allItems[i] === newItem {
                lastRow = i
                break
            }
        }
        
        let indexPath = NSIndexPath(forRow: lastRow, inSection: 0)
        
        // Insert this new row into the table
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        // If you are currently in editing mode...
        if editing {
            // Change the text of the button to inform user of state
            sender.setTitle("Edit", forState: UIControlState.Normal)
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change the text of the button to inform user of state
            sender.setTitle("Done", forState: UIControlState.Normal)
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }

    //all instances of TableViewController should use UITableViewStyle.Plain
    //and this initializer
    convenience override init(){
        //self.init(style: UITableViewStyle.)
        self.init(style: UITableViewStyle.Grouped)
        
        for i in 0..<10{
            println(i)
            //BNRItemStore.sharedStore.createItem()
        }
    }

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: UITableViewStyle.Grouped)
        
        var navItem = self.navigationItem
        navItem.title = "Homepwner"
        
        //Create a new bar button item that will send
        //addNewItem: to BNRItemsBiewController
        var bbi = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Bordered, target: self, action: "newadd")
        //Set this bar button item as the right item in the navigationITem
        navItem.rightBarButtonItem = bbi
        navItem.leftBarButtonItem = self.editButtonItem()
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func newadd(){
        let newItem = BNRItemStore.sharedStore.createItem()
        
        // Figure out where that item is in the array
        var lastRow: Int = 0
        for i in 0..<BNRItemStore.sharedStore.allItems.count {
            if BNRItemStore.sharedStore.allItems[i] === newItem {
                lastRow = i
                break
            }
        }
        println("newItem index is \(lastRow)")
        
        let indexPath = NSIndexPath(forRow: lastRow, inSection: 0)
        
        // Insert this new row into the table
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)

    }
    
    
    //UITableViewController.init(style: ) automatically calls "unimplemented intializer 'init(nibName: bundle: )"
    //should use this
    /*init(){
        super.init(style: UITableViewStyle.Plain)
        
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        let header = self.headerView
        //self.tableView.tableHeaderView = header
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BNRItemStore.sharedStore.allItems.count + 1
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell

        if indexPath.row < BNRItemStore.sharedStore.allItems.count {
            let item = BNRItemStore.sharedStore.allItems[indexPath.row]
            cell.textLabel!.text = item.description
        } else {
            // The last row
            cell.textLabel!.text = "No more items!"
        }
        
        // Configure the cell...
       // var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UITableViewCell")
    
        //Set the text on the cell with the description of the item
        //that is at the nth index of items, where n = row this cell
        //will appear in on the tableview
        
    
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row < BNRItemStore.sharedStore.allItems.count){
            if(editingStyle == UITableViewCellEditingStyle.Delete){
                let items = BNRItemStore.sharedStore.allItems
                let item = items[indexPath.row]
                BNRItemStore.sharedStore.removeItem(item)
                
                //Remove that row from tableView with an animation
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if(sourceIndexPath.row < BNRItemStore.sharedStore.allItems.count){
            BNRItemStore.sharedStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
        }
    }
    
    //Set which row can be edited
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // All but the last row can be edited
        if indexPath.row < BNRItemStore.sharedStore.allItems.count {
            return true
        } else {
            return false
        }
    }
    
    // Set which rows can be moved
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // All but the last row can be moved
        if indexPath.row < BNRItemStore.sharedStore.allItems.count {
            return true
        } else {
            return false
        }
    }
    
    // Renaming the Delete Button when editing rows
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        
        return "Remove"
    }
    
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        
        // If target row is last row, then make it the row just before the last
        if proposedDestinationIndexPath.row < BNRItemStore.sharedStore.allItems.count {
            return proposedDestinationIndexPath
        }
        else {
            return NSIndexPath(forRow: proposedDestinationIndexPath.row - 1, inSection: 0)
        }
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewcontroller = BNRDetailViewController(nibName: "BNRDetailViewController", bundle: NSBundle.mainBundle())
        
        var items = BNRItemStore.sharedStore.allItems
        var selectedITem = items[indexPath.row]
        
        //Give detail view controller a pointer to the item object in row
        detailViewcontroller.item = selectedITem
        
        //Push it onto the top of the navigation controller's stack
        self.navigationController!.pushViewController(detailViewcontroller, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
}
