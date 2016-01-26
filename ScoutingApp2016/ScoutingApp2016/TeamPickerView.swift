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
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Done, target: self, action: "back")
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = nil
        
        // Assign the navigation item to the navigation bar
        (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.items = [navigationItem]
        
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
    
    func back(){
        UIApplication.sharedApplication().keyWindow?.rootViewController?.view.addSubview(HomeView())
        self.removeFromSuperview()
        (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.items = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}