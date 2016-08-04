//
//  FontTableController.swift
//  iOS_CodeDemo
//
//  Created by mac book on 16/6/28.
//  Copyright © 2016年 mac book. All rights reserved.
//

import UIKit


// MARK:@objc(FontTableController)是为了在调用NSClassFromString()的时候可以拿到类名
@objc(FontTableController) class FontTableController: UITableViewController {

    var dataResource : [String]!{
        get{
            return UIFont.familyNames()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataResource.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reu = "res"
        var cell = tableView.dequeueReusableCellWithIdentifier(reu)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reu)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
        }
        
        let fontName = dataResource[indexPath.row]
        cell?.textLabel?.text = fontName + "(中文)"
        let font = UIFont.init(name: fontName, size: 14)
        cell?.textLabel?.font = font
        cell?.detailTextLabel?.text = fontName
        cell?.detailTextLabel?.font = UIFont.systemFontOfSize(12)
        
        return cell!
    }
    

}
