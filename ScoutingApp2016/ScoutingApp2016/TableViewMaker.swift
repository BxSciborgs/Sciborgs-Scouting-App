//
//  TableViewMaker.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/26/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class TableViewMaker: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var title: UILabel!
    var tableView: UITableView!
    var cells: [UITableViewCell!]!
    
    
    init(titleString: String){
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.backgroundColor = UIColor.whiteColor()
        
        cells = []
        
        title = UILabel(frame:  CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height/8))
        title.text = titleString
        title.textAlignment = NSTextAlignment.Center
        title.center = CGPoint(x: Screen.width/2, y: Screen.height/8)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/4), style: UITableViewStyle.Plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
//        //Create list of teams
//        BlueAlliance.sendRequest(CompetitionCode.Javits, completion: {(teamNames: [String], teamNumbers: [Int]) -> Void in
//            dispatch_async(dispatch_get_main_queue(), {
//                for x in 0..<teamNumbers.count{
//                    self.makeCell(teamNames[x], number: teamNumbers[x])
//                }
//                self.tableView.reloadData()
//            })
//        })
            
        tableView.center = CGPoint(x: Screen.width/2, y: Screen.height/2 + Screen.height/8)
        
        self.addSubview(tableView)
        self.addSubview(title)
    }
    
    func makeCell(text: String){
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/8))
        let nameText = UILabel(frame: cell.frame)
        
        nameText.text = text
        nameText.textAlignment = NSTextAlignment.Left
        nameText.center = CGPoint(x: nameText.center.x + Screen.width * 0.05, y: nameText.center.y)
        
        cell.contentView.addSubview(nameText)
        addCell(cell)
    }
    
    func addCell(cell: UITableViewCell){
        cells.append(cell)
        tableView.insertSubview(cell, atIndex:  cells.count - 1)
    }
    
    func addToTable(info: [UITableViewCell]){
        dispatch_async(dispatch_get_main_queue(), {
            for item in info{
                self.addCell(item)
            }
            self.tableView.reloadData()
        })

    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Link to team profile
        print(indexPath.row)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return cells[indexPath.row]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}