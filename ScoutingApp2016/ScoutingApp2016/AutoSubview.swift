//
//  AutoSubview.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 2/1/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class AutoSubview: UIView{
    
    var autoInput: [UISegmentedControl!]!
    
    var segmentedControls: [UISegmentedControl]! = []
    var segmentedNames: [String]! = []
    
    init(segmentedColor: UIColor) {
        super.init(frame:
            CGRectMake(
                0, 0,
                Screen.width, Screen.height
            )
        )
        //AUTO PANE OF SCROLLVIEW

        autoInput = []
        
        print("1.25")
        let autoLabel = BasicLabel(
            frame: Screen.frame,
            text: "Autonomous",
            fontSize: 50,
            color: UIColor.darkGrayColor(),
            position: CGPoint(
                x: Screen.width/2,
                y: 0
            )
        )
        
        self.addSubview(autoLabel)
        
        segmentedNames = ["movedToDefense", "passedDefense", "lowGoal", "highGoal"]
        let labels: [String] = ["Moved to Defense", "Passed Defense", "Low Goal", "High Goal"]
        
        var controlTag = 0
        for i in 0..<segmentedNames.count {
            let segmentedControl = UISegmentedControl(items: ["True", "False"])
            segmentedControl.selectedSegmentIndex = 1

            let attr = NSDictionary(object: UIFont(name: "DINCondensed-Bold", size: 25 * ScreenRatios.screenWidthRatio)!, forKey: NSFontAttributeName)
            UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)

            segmentedControl.subviews[0].tintColor = segmentedColor
            segmentedControl.subviews[1].tintColor = segmentedColor

            segmentedControl.frame = CGRectMake(
                3/5*Screen.width,
                CGFloat(((1+(Double(1.7)*Double(i)))/10))*Screen.height,
                1/3*Screen.width,
                Screen.width/5
            )
            
            segmentedControl.name = segmentedNames[i]

            let yPos = CGFloat(((1.4+(Double(1.7)*Double(i)))/10))
            let label = BasicLabel(frame: Screen.frame, text: labels[i], fontSize: 30, color: UIColor.darkGrayColor(), position: CGPoint(x: 1.5/5*Screen.width, y: yPos*Screen.height))

            segmentedControl.addTarget(self, action: "controlFix:", forControlEvents: .ValueChanged)
            segmentedControl.tag = controlTag
            controlTag += 1
            
            segmentedControls.append(segmentedControl)

            autoInput.append(segmentedControl)
            
            self.addSubview(segmentedControl)
            self.addSubview(label)
        }
    }
    
    func controlFix(sender: UISegmentedControl){
        if (sender.selectedSegmentIndex == 0) {
            if (sender.tag == 2 || sender.tag == 3) {
                autoInput[0].selectedSegmentIndex = 0
                autoInput[1].selectedSegmentIndex = 0
                
                autoInput[0].userInteractionEnabled = false
                autoInput[1].userInteractionEnabled = false
                if (sender.tag == 2){
                    autoInput[3].selectedSegmentIndex = 1
                }
                else {
                    autoInput[2].selectedSegmentIndex = 1
                }
            } else if (sender.tag == 1) {
                autoInput[0].selectedSegmentIndex = 0
                autoInput[0].userInteractionEnabled = false
            }
        } else {
            autoInput[0].userInteractionEnabled = true
            autoInput[1].userInteractionEnabled = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}