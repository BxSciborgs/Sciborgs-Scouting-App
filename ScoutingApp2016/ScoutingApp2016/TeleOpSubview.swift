//
//  TeleOpSubview.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 2/1/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class TeleOpSubview: UIView, UIScrollViewDelegate, UITextFieldDelegate{
    
    var stepperLabels: [BasicLabel]! = []
    var steppers: [UIStepper]! = []
    var stepperColor: UIColor!
    
    var commentTextBox: UITextField!
    
    var teleLabels: [String]!
    var teleNames: [String]!
    
    var segmentedControls: [UISegmentedControl]! = []
    
    init(stepperColor: UIColor){
        super.init(frame:
            CGRectMake(
                Screen.width, 0,
                Screen.width, Screen.height
            )
        )
        
        self.stepperColor = stepperColor
        
        let teleLabel = BasicLabel(
            frame: self.frame,
            text: "Teleoperated",
            fontSize: 50,
            color: UIColor.darkGrayColor(),
            position: CGPoint(
                x: self.frame.width/2,
                y: 0
            )
        )
    
        let teleVerticalScroller = UIScrollView(frame: CGRect(x: 0, y: bsConstants.pjl, width: self.frame.width, height: self.frame.height + CGFloat(self.frame.height/4)))
        teleVerticalScroller.delegate = self
        teleVerticalScroller.directionalLockEnabled = true
        teleVerticalScroller.indicatorStyle = UIScrollViewIndicatorStyle.Black
        teleVerticalScroller.contentSize = CGSize(width: self.frame.width, height: 2*teleVerticalScroller.frame.height)
        teleVerticalScroller.alpha = 1
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.addGestureRecognizer(tap)
        
        teleLabels = [
            "Comments",
            "Crossed Portcullis",
            "Crossed Cheval DeFrise",
            "Crossed Moat",
            "Crossed Ramparts",
            "Crossed Drawbridge",
            "Crossed SallyPort",
            "Crossed RockWall",
            "Crossed RoughTerrain",
            "Crossed LowBar",
            "Low Goal",
            "High Goal",
            "Disabled",
            "Driver Score",
            "Challenge",
            "Scale"
        ]
        teleNames = [
            "comments",
            "numTimesCrossedPortcullis",
            "numTimesCrossedChevalDeFrise",
            "numTimesCrossedMoat",
            "numTimesCrossedRamparts",
            "numTimesCrossedDrawbridge",
            "numTimesCrossedSallyPort",
            "numTimesCrossedRockWall",
            "numTimesCrossedRoughTerrain",
            "numTimesCrossedLowBar",
            "low",
            "high",
            "disabled",
            "driverScore",
            "challenge",
            "scale"
        ]
        
        for i in 0..<teleLabels.count {
            let yPos = CGFloat(((0.5+(Double(1.2)*Double(i)))/10))
            let label = BasicLabel(
                frame: self.frame,
                text: teleLabels[i],
                fontSize: 25,
                color: UIColor.darkGrayColor(),
                position: CGPoint(
                    x: 1.4/5*self.frame.width,
                    y: yPos*self.frame.height
                )
            )
            if(i == 0) {
                commentTextBox = UITextField(frame: CGRectMake((2.75/5)*self.frame.width,
                    yPos*self.frame.height - (self.frame.height/200), self.frame.width/2.6, self.frame.height/20))
                commentTextBox.placeholder = "Comments..."
                commentTextBox.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
                commentTextBox.delegate = self
                teleVerticalScroller.addSubview(commentTextBox)
            }else if (i < 14) {
                let labelStepper = UIStepper(frame: CGRectMake(2.75/5*self.frame.width, yPos*self.frame.height - (self.frame.height/100),self.frame.width/4,self.frame.height/10))
                labelStepper.autorepeat = false
                labelStepper.minimumValue = -1
                labelStepper.maximumValue = 9
                labelStepper.tag = i-1
                labelStepper.tintColor = stepperColor
                steppers.append(labelStepper)
                
                let stepperLabel = BasicLabel(
                    frame: self.frame,
                    text: "\(Int(labelStepper.value))",
                    fontSize: 30,
                    color: UIColor.darkGrayColor(),
                    position: CGPoint(
                        x: (4.5/5)*self.frame.width,
                        y: yPos*self.frame.height - (self.frame.height/200)
                    )
                )
                
                stepperLabels.append(stepperLabel)
                
                labelStepper.addTarget(self, action: "changeLabelValue:", forControlEvents: UIControlEvents.ValueChanged)
                
                teleVerticalScroller.addSubview(labelStepper)
                teleVerticalScroller.addSubview(stepperLabel)
            }else {
                let segmentedControl = UISegmentedControl(items: ["True", "False"])
                segmentedControl.selectedSegmentIndex = 1
                
                let attr = NSDictionary(object: UIFont(name: "DINCondensed-Bold", size: 25 * ScreenRatios.screenWidthRatio)!, forKey: NSFontAttributeName)
                UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
                
                segmentedControl.subviews[0].tintColor = stepperColor
                segmentedControl.subviews[1].tintColor = stepperColor
                
                segmentedControl.frame = CGRectMake(
                    3/5.8*Screen.width,
                    yPos*self.frame.height - 1/30*Screen.width,
                    1/3*Screen.width,
                    Screen.width/10
                )
                
                segmentedControls.append(segmentedControl)
                
                teleVerticalScroller.addSubview(segmentedControl)
            }
        
            teleVerticalScroller.addSubview(label)
        }
        
        self.addSubview(teleLabel)
        self.addSubview(teleVerticalScroller)
    }
    
    func changeLabelValue(sender: UIStepper) {
        if(Int(sender.value) == -1) {
            stepperLabels[sender.tag].text = "-"
        }else {
            stepperLabels[sender.tag].text = "\(Int(sender.value))"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        return newLength <= 50
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.endEditing(true)
    }
}
