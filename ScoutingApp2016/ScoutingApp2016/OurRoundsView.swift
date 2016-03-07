//
//  TeamSummaryRoundView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 3/5/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation

class OurRoundsView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var cells: [UITableViewCell!]!
    
    var matchNumbers: [Int]! = []
    var matches: [JSON]! = []
    
    var teamOrder: [String]! = []
    
    var sciBorgsTeamProfile: Team!
    var feMaidensTeamProfile: Team!
    
    init() {
        super.init(frame:
            CGRectMake(
                0, 0,
                Screen.width, Screen.height
            )
        )
        self.backgroundColor = UIColor.whiteColor()
        
        let title = BasicLabel(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height), text: "OUR ROUNDS", fontSize: 60, color: UIColor.darkGrayColor(), position: CGPoint(x: Screen.width/2, y: Screen.height/8))
        
        self.addSubview(title)
        
        cells = []
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/4), style: UITableViewStyle.Plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        sciBorgsTeamProfile = Team(teamNumber: 1155)
        sciBorgsTeamProfile.getAllParticipatingMatches({(matches: [JSON]) -> Void in
            if matches.count > 0 {
                for x in 0..<matches.count{
                    self.makeCell(matches[x], teamName: "SciBorgs")
                }
                self.tableView.reloadData()
            }
        })
        
        feMaidensTeamProfile = Team(teamNumber: 2265)
        feMaidensTeamProfile.getAllParticipatingMatches({(matches: [JSON]) -> Void in
            if matches.count > 0 {
                for x in 0..<matches.count{
                    self.makeCell(matches[x], teamName: "FeMaidens")
                }
                self.tableView.reloadData()
            }
        })
        
        tableView.center = CGPoint(x: Screen.width/2, y: Screen.height/2 + Screen.height/10)
        
        self.addSubview(tableView)
    }
    
    func makeCell(match: JSON, teamName: String){
        matchNumbers.append(match["match_number"].int!)
        matches.append(match)
        
        teamOrder.append(teamName)
        
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/8))
        
        let roundNum = UILabel(frame: cell.frame)
        roundNum.text = "\(teamName) Qualifying Match \(match["match_number"].stringValue)"
        roundNum.textAlignment = NSTextAlignment.Left
        roundNum.center = CGPoint(x: roundNum.center.x + Screen.width * 0.05, y: roundNum.center.y)
        
        cell.contentView.addSubview(roundNum)
        
        cells.append(cell)
        tableView.insertSubview(cell, atIndex: cells.count-1)
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let blueTeams = BlueAlliance.getTeamsFromMatch(matches[indexPath.row], color: "blue")
        let redTeams = BlueAlliance.getTeamsFromMatch(matches[indexPath.row], color: "red")
        
        let teamView = TeamAssignmentView(
            blueTeams: blueTeams,
            redTeams: redTeams,
            roundNumber:  indexPath.row+1,
            mode: AssignmentMode.REVIEW
        )
        
        var selectedEnemyTeams: [Int] = []
        if(teamOrder[indexPath.row] == "SciBorgs") {
            selectedEnemyTeams = sciBorgsTeamProfile.getAllianceAndEnemyTeamsFromMatch(matches[indexPath.row]).enemyTeams
        }else if (teamOrder[indexPath.row] == "FeMaidens") {
            selectedEnemyTeams = feMaidensTeamProfile.getAllianceAndEnemyTeamsFromMatch(matches[indexPath.row]).enemyTeams
        }
        let  roundSummaryView = RoundSummaryView(teamAssignmentView: teamView, enemyTeams: selectedEnemyTeams)
        
        self.launchViewOnTop(roundSummaryView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return cells[indexPath.row]
    }
    
    func onClick() {
        print("Hello")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
