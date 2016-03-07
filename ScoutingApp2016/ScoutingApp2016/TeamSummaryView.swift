//
//  TeamRoundView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 3/5/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import UIKit

class TeamSummaryView: UIView, UIScrollViewDelegate, UITextFieldDelegate {
    
    var allRounds: [JSON]!
    var numberOfRounds: Double!
    
    var jsonKeys: [String]!
    var jsonKeyLabels: [String]!
    
    var keyLabelsDictionary: [String: AnyObject]! = [:]
    
    init(allRounds: [JSON]) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.backgroundColor = UIColor.whiteColor()
        self.addBackButton()
        
        if(allRounds.count != 0) {
            self.numberOfRounds = Double(allRounds.count)
        }else {
            self.numberOfRounds = 1
        }
        
        self.allRounds = allRounds
        
        let teamNumberLabel = BasicLabel(
            frame: self.frame,
            text: "Summary",
            fontSize: 50,
            color: UIColor.darkGrayColor(),
            position: CGPoint(
                x: Screen.width/2,
                y: 0
            )
        )
        
        jsonKeys = [
            "movedToDefense",
            "passedDefense",
            "lowGoal",
            "highGoal",
            "numTimesCrossedPortcullis",
            "numTimesCrossedChevalDeFrise",
            "numTimesCrossedMoat",
            "numTimesCrossedRamparts",
            "numTimesCrossedDrawbridge",
            "numTimesCrossedSallyPort",
            "numTimesCrossedRockWall",
            "numTimesCrossedRoughTerrain",
            "numTimesCrossedLowBar",
            "high",
            "low",
            "challenge",
            "scale"
        ]
        
        jsonKeyLabels = [
            "Moved To Defense: ",
            "Passed Defense: ",
            "Auto Low Goal: ",
            "Auto High Goal ",
            "Crossed Portcullis: ",
            "Crossed ChevalDeFrise: ",
            "Crossed Moat: ",
            "Crossed Ramparts: ",
            "Crossed Drawbridge: ",
            "Crossed SallyPort: ",
            "Crossed RockWall: ",
            "Crossed RoughTerrain: ",
            "Crossed LowBar: ",
            "Tele High Goal: ",
            "Tele Low Goal: ",
            "Challenge: ",
            "Scale: "
        ]
        
        for i in 0..<jsonKeys.count {
            if(i < 4) {
                keyLabelsDictionary[jsonKeyLabels[i]] = getAvgBooleanValue(jsonKeys[i])
            }else if (i < 15) {
                keyLabelsDictionary[jsonKeyLabels[i]] = Double(round(10*getAvgNumberValue(jsonKeys[i]))/10)
            }else if (i < 17) {
                keyLabelsDictionary[jsonKeyLabels[i]] = getAvgBooleanValue(jsonKeys[i])
            }
        }
        
        let teleVerticalScroller = UIScrollView(frame: CGRect(x: 0, y: bsConstants.pjl * 0.75, width: self.frame.width, height: self.frame.height))
        teleVerticalScroller.delegate = self
        teleVerticalScroller.directionalLockEnabled = true
        teleVerticalScroller.indicatorStyle = UIScrollViewIndicatorStyle.Black
        teleVerticalScroller.contentSize = CGSize(width: self.frame.width, height: 2*teleVerticalScroller.frame.height)
        teleVerticalScroller.alpha = 1
        
        for i in 0..<jsonKeyLabels.count {
            let yPos = CGFloat(((0.5+(Double(1)*Double(i)))/10))
            let labelName = BasicLabel(
                frame: self.frame,
                text: jsonKeyLabels[i],
                fontSize: 30,
                color: UIColor.darkGrayColor(),
                position: CGPoint(
                    x: 1.6/5*self.frame.width,
                    y: yPos*self.frame.height
                )
            )
            let labelKey = BasicLabel(
                frame: self.frame,
                text: "\(keyLabelsDictionary![jsonKeyLabels[i]]!)",
                fontSize: 30,
                color: UIColor.darkGrayColor(),
                position: CGPoint(
                    x: (self.frame.width/2) + 1.0/5*self.frame.width,
                    y: yPos*self.frame.height
                )
            )
            teleVerticalScroller.addSubview(labelKey)
            teleVerticalScroller.addSubview(labelName)
        }
        
        self.addSubview(teamNumberLabel)
        self.addSubview(teleVerticalScroller)
    }
    
    func getAvgBooleanValue(key: String) -> String {
        var numberOfTrueValues = 0
        var numberOfFalseValues = 0
        
        var autoPointsKeys = ["movedToDefense", "passedDefense", "lowGoal", "highGoal"]
        var telePointsKeys = ["challenge", "scale"]
        
        for round in allRounds {
            if(autoPointsKeys.contains(key)) {
                if(round["autoPoints"][key].boolValue == true) {
                    numberOfTrueValues = numberOfTrueValues + 1
                }else {
                    numberOfFalseValues = numberOfTrueValues + 1
                }
            }else if(telePointsKeys.contains(key)) {
                if(round["telePoints"][key].boolValue == true) {
                    numberOfTrueValues = numberOfTrueValues + 1
                }else {
                    numberOfFalseValues = numberOfTrueValues + 1
                }
            }
        }
        
        return (numberOfTrueValues >= numberOfFalseValues ? "True" : "False")
    }
    
    func getAvgNumberValue(key: String) -> Double {
        var avgValue: Double = 0
        
        var defenses = ["numTimesCrossedPortcullis",
            "numTimesCrossedChevalDeFrise",
            "numTimesCrossedMoat",
            "numTimesCrossedRamparts",
            "numTimesCrossedDrawbridge",
            "numTimesCrossedSallyPort",
            "numTimesCrossedRockWall",
            "numTimesCrossedRoughTerrain",
            "numTimesCrossedLowBar"]
        
        var goals = ["low", "high"]
        
        for round in allRounds {
            if(defenses.contains(key)) {
                avgValue = avgValue + round["telePoints"]["defenses"][key].doubleValue
            }else if(goals.contains(key)) {
                avgValue = avgValue + round["telePoints"]["goals"][key].doubleValue
            }
        }
        return (avgValue/numberOfRounds)
    }
    
    func back(){
        self.goBack()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
