//
//  TeamSelectionView.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class TeamSelectionView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var title: BasicLabel!
    var tableView: UITableView!
    var cells: [UITableViewCell!]!
    var teamNumbersArray: [Int]!
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.backgroundColor = UIColor.whiteColor()
        
        // Premade code that adds a back button and calls  a "back" method
        self.addBackButton()
        
        cells = []
        
        title = BasicLabel(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height), text: "TEAMS", fontSize: 60, color: UIColor.darkGrayColor(), position: CGPoint(x: Screen.width/2, y: Screen.height/8))
    
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height*0.6), style: UITableViewStyle.Plain)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        let ourTeamsButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor.lightGrayColor(), size: CGRect(x: 0, y: 0, width: frame.width/1.5, height: frame.width/4.5), location: CGPoint(x: frame.width/2,y: 1.15*frame.height/4), title: "OUR ROUNDS", titleSize: 50)
        ourTeamsButton.addTarget(self, action: "openOurTeams", forControlEvents: UIControlEvents.TouchUpInside)

        self.addSubview(ourTeamsButton)
        
        //Create list of teams
        BlueAlliance.sendRequestTeams(CompetitionCode.Javits, completion: {(teamNames: [String], teamNumbers: [Int]) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.teamNumbersArray = teamNumbers
                for x in 0..<teamNumbers.count{
                    self.makeCell(teamNames[x], number: teamNumbers[x])
                }
                self.tableView.reloadData()
            })
        })
        
        // centering the table view
        tableView.center = CGPoint(x: Screen.width/2, y: Screen.height/2 + Screen.height/5.7)

        //adding them
        self.addSubview(tableView)
        self.addSubview(title)
    }
    
    // Creates a cell for the tableview
    func makeCell(name: String , number: Int){
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/8))
        let nameText = UILabel(frame: cell.frame)
        
        let maxLength = 30
        
        //checks to make sure the name isnt too long
        if (name.characters.count >= maxLength){
            nameText.text = name.substring(0, end: maxLength-3) + "..."
        } else{
            nameText.text = name
        }
        
        nameText.textAlignment = NSTextAlignment.Left
        nameText.center = CGPoint(x: nameText.center.x + Screen.width * 0.05, y: nameText.center.y)
        
        let numberText = UILabel(frame: cell.frame)
        numberText.text = String(number)
        numberText.textAlignment = NSTextAlignment.Right
        numberText.center = CGPoint(x: numberText.center.x - (Screen.width * 0.05), y: numberText.center.y)
        
        cell.contentView.addSubview(nameText)
        cell.contentView.addSubview(numberText)
        cells.append(cell)
        
        tableView.insertSubview(cell, atIndex: cells.count - 1)
    }
    
    func back(){
        self.goBack()
        self.removeNavBar()
    }
    
    func openOurTeams() {
        let sciBorgsTeamProfile: Team  = Team(teamNumber: 1155)
        sciBorgsTeamProfile.getAllParticipatingMatches({(matches: [JSON]) -> Void in
            let sciBorgsMatches = matches
            self.launchViewOnTop(OurRoundsView())
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Team\(teamNumbersArray[indexPath.row])")
        DBManager.pull(ParseClass.TeamsTest.rawValue, rowKey: "teamNumber", rowValue: teamNumbersArray[indexPath.row], finalKey: "TeamInfo", completion: {(result: JSON) -> Void in
            self.launchViewOnTop(TeamProfileView(teamNumber: self.teamNumbersArray[indexPath.row], json: result))
        })
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

extension UITableViewCell{
    
}
