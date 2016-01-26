//
//  File.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/26/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class RoundsView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var title: UILabel!
    var tableView: UITableView!
    var cells: [UITableViewCell!]!
    
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.backgroundColor = UIColor.whiteColor()
        
        cells = []
        
        title = UILabel(frame:  CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height/8))
        title.text = "Matches"
        title.textAlignment = NSTextAlignment.Center
        title.center = CGPoint(x: Screen.width/2, y: Screen.height/8)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/4), style: UITableViewStyle.Plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        //Create list of teams
        GetTeams.sendRequestMatches(CompetitionCode.Javits, completion: {(matches: Int) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                for number in 0..<matches{
                    self.makeCell(number + 1)
                }
                self.tableView.reloadData()
            })
        })
        
        
//        , completion: {(teamNames: [String], teamNumbers: [Int]) -> Void in
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
    
    func makeCell(number: Int){
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/8))
        let matchText = UILabel(frame: cell.frame)
        
        matchText.textAlignment = NSTextAlignment.Center
       
        matchText.text = "Match " + String(number)
        
        cell.contentView.addSubview(matchText)
        
        cells.append(cell)
        tableView.insertSubview(cell, atIndex: cells.count - 1)
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
