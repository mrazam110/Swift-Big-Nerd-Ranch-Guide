//
//  BNRItemsTableViewController.swift
//  08-UITableViewAndUITableViewController
//
//  Created by Raza Master on 1/3/15.
//  Copyright (c) 2015 raza. All rights reserved.
//

import UIKit

class BNRItemsTableViewController: UITableViewController {
    
    //all instances of TableViewController should use UITableViewStyle.Plain
    //and this initializer
    convenience override init(){
        //self.init(style: UITableViewStyle.)
        self.init(style: UITableViewStyle.Grouped)
        
        for i in 0..<5{
            println(i)
            BNRItemStore.sharedStore.createItem()
        }
        
    }
    
    //UITableViewController.init(style: ) automatically calls "unimplemented intializer 'init(nibName: bundle: )"
    //should use this
    /*init(){
    super.init(style: UITableViewStyle.Plain)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if(section == 0){
            return BNRItemStore.sharedStore.allItemsMoreThanFif().count + 1
        }else if(section == 1){
            return BNRItemStore.sharedStore.allItemsLessThanFif().count + 1
        }else{
            return 0
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        if(section == 0){
            return "Item Over $50"
        }
        else {
            return "Item Below or Equal to $50"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell
        
        let itemOverFifty = BNRItemStore.sharedStore.allItemsMoreThanFif()
        let itemBelowFifty = BNRItemStore.sharedStore.allItemsLessThanFif()
        
        var item = BNRItem()
        
        if(indexPath.section == 0){
            if(indexPath.row < itemOverFifty.count){
                item = itemOverFifty[indexPath.row]
                cell.textLabel!.text = item.description
                cell.textLabel!.font = UIFont.systemFontOfSize(20.0)
            }else{
                cell.textLabel!.text = "No more Items!"
                cell.textLabel!.font = UIFont.systemFontOfSize(14)
            }
        }
        
        if(indexPath.section == 1){
            if(indexPath.row < itemBelowFifty.count){
                item = itemBelowFifty[indexPath.row]
                cell.textLabel!.text = item.description
                cell.textLabel!.font = UIFont.systemFontOfSize(20.0)
            }else{
                cell.textLabel!.text = "No more Items!"
                cell.textLabel!.font = UIFont.systemFontOfSize(14.0)
            }
        }
        
        
        // Configure the cell...
        // var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UITableViewCell")
        
        //Set the text on the cell with the description of the item
        //that is at the nth index of items, where n = row this cell
        //will appear in on the tableview
        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let itemOverFifty = BNRItemStore.sharedStore.allItemsMoreThanFif()
        let itemBelowFifty = BNRItemStore.sharedStore.allItemsLessThanFif()
        
        if(indexPath.section == 0){
            if(indexPath.row < itemOverFifty.count){
                return 60.0
            }else{
                return 44.0
            }
        }else{
            if(indexPath.row < itemBelowFifty.count){
                return 60.0
            }else{
                return 44.0
            }
        }
        
    }
    
}