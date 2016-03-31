//
//  ScoutView.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

public enum Defenses: Int {
    case Portcullis = 0
    case ChevalDeFrise = 1
    case Moat = 2
    case Ramparts = 3
    case Drawbridge = 4
    case SallyPort = 5
    case RockWall = 6
    case RoughtTerrain = 7
    case LowBar = 8
}

public struct bsConstants {
    static let svh = 7/32 * Screen.height
    static let pjl = 3/32 * Screen.height
}


class ScoutView: UIView, UIScrollViewDelegate{
    
    var scrollView: UIScrollView!
    
    var teamNumberLabel: BasicLabel!
    
    var autoInput: [UISegmentedControl!]!
    
    var segmentedColor: UIColor!
    
    var teamNumber: Int!
    var roundNumber: Int!
    
    var currentTeamProfile: Team!
    var autoView: AutoSubview!
    var teleView: TeleOpSubview!
    var reviewView: ReviewView!
    
    init(teamNumber: Int, roundNumber: Int!, color: UIColor){
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.teamNumber = teamNumber
        self.roundNumber = roundNumber
        
        currentTeamProfile = Team(teamNumber: self.teamNumber)
        currentTeamProfile.createRound(self.roundNumber)
        
        print("Scouting Round\(self.roundNumber)")
        
        segmentedColor = color
        
        autoInput = []
        
        teamNumberLabel = BasicLabel(
            frame: self.frame,
            text: "\(teamNumber)",
            fontSize: 80,
            color: UIColor.whiteColor(),
            position: CGPoint(
                x: Screen.width/2,
                y: Screen.height/12
            )
        )
    
        let colorView = UIView(frame: CGRectMake(0, Screen.height/12, Screen.width, Screen.height/11.7))
        colorView.backgroundColor = segmentedColor
        
        //OFFSET SCROLLVIEW
    
        scrollView = UIScrollView(frame: CGRectMake(0, bsConstants.svh, self.frame.width, self.frame.height-bsConstants.svh))
        scrollView.delegate = self
        scrollView.directionalLockEnabled = true
        scrollView.pagingEnabled = true
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.Black
        scrollView.contentSize = CGSize(width: self.frame.width * 3, height: self.frame.height-bsConstants.svh)
        scrollView.alpha = 1
        
    
        //AUTO PANE OF SCROLLVIEW

        autoView = AutoSubview(segmentedColor: segmentedColor)
        teleView = TeleOpSubview(stepperColor: segmentedColor)
        reviewView = ReviewView(submitColor: segmentedColor)
        
        reviewView.submitButton.addTarget(self, action: "finalizeJSON", forControlEvents: UIControlEvents.TouchUpInside)
        
        scrollView.addSubview(autoView)
        scrollView.addSubview(teleView)
        scrollView.addSubview(reviewView)
        
        self.backgroundColor = UIColor.whiteColor()
        
        print("view created for team " + String(teamNumber))

        self.addBackButton()
        self.addSubview(scrollView)
        self.addSubview(colorView)
        self.addSubview(teamNumberLabel)
    }
    
    func finalizeAutoView() {
        for i in 0..<autoView.segmentedControls.count {
            if(autoView.segmentedControls[i].selectedSegmentIndex == 0) { //true
                currentTeamProfile.currentRound.template!["autoPoints"][autoView.segmentedNames[i]].bool = true
            }else { //false
                currentTeamProfile.currentRound.template!["autoPoints"][autoView.segmentedNames[i]].bool = false
            }
        }
    }
    
    func finalizeTeleView() {
        for i in 0..<teleView.teleLabels.count {
            if(i == 0) {
                currentTeamProfile.currentRound.template![teleView.teleNames[i]].string = teleView.commentTextBox.text!
            }else if (i < 10) {
                currentTeamProfile.currentRound.template!["telePoints"]["defenses"][teleView.teleNames[i]].int = Int(teleView.steppers[i-1].value)
            }else if (i < 12) {
                currentTeamProfile.currentRound.template!["telePoints"]["goals"][teleView.teleNames[i]].int = Int(teleView.steppers[i-1].value)
            }else if (i < 14) {
                currentTeamProfile.currentRound.template![teleView.teleNames[i]].int = Int(teleView.steppers[i-1].value)
            }
        }
        
        for i in 0..<teleView.segmentedControls.count {
            if(teleView.segmentedControls[i].selectedSegmentIndex == 0) { //true
                currentTeamProfile.currentRound.template!["telePoints"][teleView.teleNames[i+14]].bool = true
            }else { //false
                currentTeamProfile.currentRound.template!["telePoints"][teleView.teleNames[i+14]].bool = false
            }
        }
    }
    
    func finalizeJSON() {
        
        currentTeamProfile.currentRound.template!["didScout"].bool = true
        
        finalizeTeleView()
        finalizeAutoView()
        
        currentTeamProfile.submitCurrentRound()
        for view in (UIApplication.sharedApplication().keyWindow?.rootViewController!.view.subviews)! {
            if let vTest = view as? HomeView {
                print(vTest)
            }else {
                view.removeFromSuperview()
            }
        }
      
    }
    
    func back(){
        self.goBack()
        //self.removeNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}