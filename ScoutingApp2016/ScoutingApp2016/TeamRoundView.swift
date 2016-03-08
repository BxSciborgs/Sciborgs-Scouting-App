//
//  TeamRoundView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 3/5/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import UIKit

class TeamRoundView: UIView, UIScrollViewDelegate, UITextFieldDelegate {
    
    var teamJSON: JSON!
    
    var jsonKeys: [String]!
    var jsonKeyLabels: [String]!
    
    var keyLabelsDictionary: [String: AnyObject]! = [:]
    
    init(json: JSON) {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
    
        self.backgroundColor = UIColor.whiteColor()
        self.addBackButton()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.addGestureRecognizer(tap)
        
        let teamNumberLabel = BasicLabel(
            frame: self.frame,
            text: "Round \(json["roundNumber"])",
            fontSize: 80,
            color: UIColor.whiteColor(),
            position: CGPoint(
                x: Screen.width/2,
                y: Screen.height/12
            )
        )
        
        let colorView = UIView(frame: CGRectMake(0, Screen.height/12, Screen.width, Screen.height/11.7))
        colorView.backgroundColor = UIColor(red: 1, green: 0.93, blue: 0.09, alpha: 1)
        
        teamJSON = json
        
        print(teamJSON["roundNumber"])
    
        jsonKeyLabels = [
            "Comments: ",
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
        
        for i in 0..<DBManager.allJSONKeys.count {
            if(i < 1) {
                keyLabelsDictionary[jsonKeyLabels[i]] = teamJSON![DBManager.allJSONKeys[i]].stringValue
            }else if(i < 5) {
                if(teamJSON!["autoPoints"][DBManager.allJSONKeys[i]].boolValue == true) {
                    //true
                    keyLabelsDictionary[jsonKeyLabels[i]] = "True"
                }else {
                    keyLabelsDictionary[jsonKeyLabels[i]] = "False"
                }
            }else if (i < 14) {
                if(teamJSON!["telePoints"]["defenses"][DBManager.allJSONKeys[i]].intValue == -1) {
                    keyLabelsDictionary[jsonKeyLabels[i]] = "-"
                }else {
                    keyLabelsDictionary[jsonKeyLabels[i]] = teamJSON!["telePoints"]["defenses"][DBManager.allJSONKeys[i]].intValue
                }
            }else if (i < 16) {
                keyLabelsDictionary[jsonKeyLabels[i]] = teamJSON!["telePoints"]["goals"][DBManager.allJSONKeys[i]].intValue
            }else if (i < 18) {
                if(teamJSON!["telePoints"][DBManager.allJSONKeys[i]].boolValue == true) {
                    //true
                    keyLabelsDictionary[jsonKeyLabels[i]] = "True"
                }else {
                    keyLabelsDictionary[jsonKeyLabels[i]] = "False"
                }
            }
        }
        
        let teleVerticalScroller = UIScrollView(frame: CGRect(x: 0, y: bsConstants.pjl * 2, width: self.frame.width, height: self.frame.height))
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
            
            if(i == 0) {
                let commentTextBox = UITextField(frame: CGRectMake((3.2/5)*self.frame.width,
                    yPos*self.frame.height - (self.frame.height/200), self.frame.width/3, self.frame.height/20))
                commentTextBox.text = "\(keyLabelsDictionary![jsonKeyLabels[i]]!)"
                commentTextBox.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
                
                teleVerticalScroller.addSubview(commentTextBox)
            }else {
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
            }
            teleVerticalScroller.addSubview(labelName)
        }
    
        self.addSubview(colorView)
        self.addSubview(teamNumberLabel)
        self.addSubview(teleVerticalScroller)
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
