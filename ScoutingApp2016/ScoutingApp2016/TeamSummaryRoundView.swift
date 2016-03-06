//
//  TeamSummaryRoundView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 3/5/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation

class TeamSummaryRoundView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var rounds: [JSON]!
    
    var tableView: UITableView!
    var cells: [UITableViewCell!]!
    
    init(rounds: [JSON]) {
        super.init(frame:
            CGRectMake(
                Screen.width, 0,
                Screen.width, Screen.height
            )
        )
        
        let roundsLabel = BasicLabel(
            frame: Screen.frame,
            text: "Rounds",
            fontSize: 50,
            color: UIColor.darkGrayColor(),
            position: CGPoint(
                x: Screen.width/2,
                y: 0
            )
        )
        
        self.addSubview(roundsLabel)
        
        cells = []

        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/3.2), style: UITableViewStyle.Plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        self.rounds = rounds
        
        if self.rounds.count > 0 {
            for x in 0..<rounds.count{
                self.makeCell(rounds[x])
            }
        }
        self.tableView.reloadData()
        
        tableView.center = CGPoint(x: Screen.width/2, y: Screen.height/2 - Screen.height/16)

        self.addSubview(tableView)
    }
    
    func makeCell(round: JSON){
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/8))
        
        let roundNum = UILabel(frame: cell.frame)
        roundNum.text = "Qualifying Match \(round["roundNumber"].stringValue)"
        roundNum.textAlignment = NSTextAlignment.Left
        roundNum.center = CGPoint(x: roundNum.center.x + Screen.width * 0.05, y: roundNum.center.y)
        
        cell.contentView.addSubview(roundNum)
        
        cells.append(cell)
        tableView.insertSubview(cell, atIndex: cells.count-1)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Link to team profile
        print("Found Round\(self.rounds[indexPath.row])")
        self.removeFromSuperview()
        self.launchViewOnTop(TeamRoundView(json: self.rounds[indexPath.row]))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return cells[indexPath.row]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
