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
            return UIFont.familyNames
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataResource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reu = "res"
        var cell = tableView.dequeueReusableCell(withIdentifier: reu)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: reu)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
        
        let fontName = dataResource[indexPath.row]
        cell?.textLabel?.text = fontName + "(中文)"
        let font = UIFont.init(name: fontName, size: 14)
        cell?.textLabel?.font = font
        cell?.detailTextLabel?.text = fontName
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell!
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.tableView.frame = CGRectMake(0, 0, 100, 667);
//    }
    

}
