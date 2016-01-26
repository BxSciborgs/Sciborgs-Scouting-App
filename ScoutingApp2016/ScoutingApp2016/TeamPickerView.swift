//
//  TeamPickerView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 1/26/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import UIKit

class TeamPickerView: UIView {
    
    var blueTeams: [Int]!
    var redTeams: [Int]!
    
    var blueTeamsLabel: UILabel!
    var redTeamsLabel: UILabel!
    
    init(frame: CGRect, blueTeams: [Int], redTeams: [Int]) {
        super.init(frame: frame)
        
        self.blueTeams = blueTeams
        self.redTeams = redTeams
        
        blueTeamsLabel = BasicLabel(frame: frame, text: "BLUE", fontSize: 75, color: UIColor(red: 0.6, green: 0.83, blue: 0.96, alpha: 1.0), position: CGPoint(x: (frame.width/2) - (frame.width/5), y: frame.height/15))
        redTeamsLabel = BasicLabel(frame: frame, text: "RED", fontSize: 75, color: UIColor(red: 1, green: 0.63, blue: 0.6, alpha: 1.0), position: CGPoint(x: (frame.width/2) + (frame.width/5), y: frame.height/15))
        
        for team in blueTeams {
            let teamButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor(red: 0.6, green: 0.83, blue: 0.96, alpha: 1.0), size: CGRect(x: 0,y: 0,width: self.frame.width/CGFloat(3), height:self.frame.width/CGFloat(3)), location: CGPoint(x: (frame.width/2) - (frame.width/5), y: CGFloat(blueTeams.indexOf(team)! + 1) * (self.frame.height/4) + CGFloat(self.frame.height/15)), title: "\(team)", titleSize: 50)
            self.addSubview(teamButton)
        }
        
        for team in redTeams {
            let teamButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor(red: 1, green: 0.63, blue: 0.6, alpha: 1.0), size: CGRect(x: 0,y: 0,width: self.frame.width/CGFloat(3), height:self.frame.width/CGFloat(3)), location: CGPoint(x: (frame.width/2) + (frame.width/5), y: CGFloat(redTeams.indexOf(team)! + 1) * (self.frame.height/4) + CGFloat(self.frame.height/15)), title: "\(team)", titleSize: 50)
            self.addSubview(teamButton)
        }
        self.addSubview(blueTeamsLabel)
        self.addSubview(redTeamsLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}