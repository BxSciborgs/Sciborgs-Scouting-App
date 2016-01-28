//
//  ViewTeamView.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class ViewTeamView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var title: BasicLabel!
    var tableView: UITableView!
    var cells: [UITableViewCell!]!
    var teamNumbersArray: [Int]!
    
    init(){
        
        print("type created")
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.backgroundColor = UIColor.whiteColor()
        
        // Premade code that adds a back button and calls  a "back" method
        self.addBackButton()
    
        cells = []
        
        title = BasicLabel(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height), text: "TEAMS", fontSize: 60, color: UIColor.darkGrayColor(), position: CGPoint(x: Screen.width/2, y: Screen.height/8))
    
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - Screen.height/4), style: UITableViewStyle.Plain)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
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
        tableView.center = CGPoint(x: Screen.width/2, y: Screen.height/2 + Screen.height/8)

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
        }
        else{
            nameText.text = name
        }
        
        nameText.textAlignment = NSTextAlignment.Left
        nameText.center = CGPoint(x: nameText.center.x + Screen.width * 0.05, y: nameText.center.y)
        
        let numberText = UILabel(frame: cell.frame)
        numberText.text = String(number)
        numberText.textAlignment = NSTextAlignment.Right
        numberText.center = CGPoint(x: numberText.center.x - Screen.width * 0.05, y: numberText.center.y)
        
        cell.contentView.addSubview(nameText)
        cell.contentView.addSubview(numberText)
        cells.append(cell)
        
        tableView.insertSubview(cell, atIndex: cells.count - 1)
    }
    
    func back(){
        self.launchView(HomeView())
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Link to team profile
        print("Team\(teamNumbersArray[indexPath.row])")
        DBManager.query("Teams", key: "Team\(teamNumbersArray[indexPath.row])", completion: {(result: JSON) -> Void in
            //print(result)
            UIApplication.sharedApplication().keyWindow?.rootViewController!.view.insertSubview(TeamProfileView(teamName: "Team\(self.teamNumbersArray[indexPath.row])", json: result), belowSubview: (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar)
            self.removeFromSuperview()
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
