//
//  TeamPickerView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 1/26/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import UIKit

enum AssignmentMode {
    case SCOUT
    case REVIEW
}

class TeamAssignmentView: UIView {
    
    var blueTeams: [Int]!
    var redTeams: [Int]!
    var teams: [Int]!
    
    var blueTeamsLabel: UILabel!
    var redTeamsLabel: UILabel!
    
    var roundNumber: Int!
    
    var teamButton: BasicButton!
    
    init(blueTeams: [Int], redTeams: [Int], roundNumber: Int!, mode: AssignmentMode) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.blueTeams = blueTeams
        self.redTeams = redTeams
        
        self.roundNumber = roundNumber
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addBackButton()
        
        blueTeamsLabel = BasicLabel(frame: frame, text: "BLUE", fontSize: 75, color: UIColor(red: 0.6, green: 0.83, blue: 0.96, alpha: 1.0), position: CGPoint(x: (frame.width/2) - (frame.width/5), y: frame.height/15))
        redTeamsLabel = BasicLabel(frame: frame, text: "RED", fontSize: 75, color: UIColor(red: 1, green: 0.63, blue: 0.6, alpha: 1.0), position: CGPoint(x: (frame.width/2) + (frame.width/5), y: frame.height/15))
        
        // created to keep track of the team button also for which button is being made
        var teamButtonTag = 0
        
        let allTeams = blueTeams + redTeams

        for team in allTeams{
            var red : CGFloat, green : CGFloat, blue : CGFloat
            var index : Int
            var sign : CGFloat
            
            if (teamButtonTag <= 2) {
                red = 0.6; green = 0.83; blue = 0.96
                index = blueTeams.indexOf(team)!
                sign = -1
            } else {
                red = 1; green = 0.63; blue = 0.6
                index = redTeams.indexOf(team)!
                sign = 1
            }
            
            teamButton = BasicButton(
                type: UIButtonType.RoundedRect,
                color: UIColor(red: red, green: green, blue: blue, alpha: 1.0),
                size: CGRect(
                    x: 0,
                    y: 0,
                    width: self.frame.width/CGFloat(3),
                    height:self.frame.width/CGFloat(3)),
                location: CGPoint(
                    x: (frame.width/2) + sign * (frame.width/5),
                    y: CGFloat(index + 1) * (self.frame.height/4) + CGFloat(self.frame.height/15)),
                title: "\(team)",
                titleSize: 50
            )
            
            if(mode == AssignmentMode.SCOUT) {
                teamButton.addTarget(nil, action: "onScoutClick:", forControlEvents: UIControlEvents.TouchUpInside)
            }else {
                teamButton.addTarget(nil, action: "onReviewClick:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            teamButton.tag = teamButtonTag
            teamButtonTag += 1
            
            self.addSubview(teamButton)
        }
        
        self.addSubview(blueTeamsLabel)
        self.addSubview(redTeamsLabel)
    }
    
    func onScoutClick(sender: UIButton){
        var buttonColor: UIColor
        
        if (sender.tag <= 2) {
            buttonColor = UIColor(red: 0.6, green: 0.83, blue: 0.96, alpha: 1)
        } else {
            buttonColor = UIColor(red: 1, green: 0.63, blue: 0.6, alpha: 1)
        }
        self.launchViewOnTop(ScoutView(teamNumber: Int((sender.titleLabel?.text)!)!, roundNumber: self.roundNumber, color: buttonColor))
    }
    
    func onReviewClick(sender: UIButton){
        DBManager.pull(ParseClass.TeamsTest.rawValue, rowKey: "teamNumber", rowValue: Int((sender.titleLabel?.text)!)!, finalKey: "TeamInfo", completion: {(result: JSON) -> Void in
            self.launchViewOnTop(TeamProfileView(teamNumber: Int((sender.titleLabel?.text)!)!, json: result))
        })
    }
    
    func back(){
        self.goBack()
        self.removeNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}