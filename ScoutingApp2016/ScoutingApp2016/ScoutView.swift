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

class ScoutView: UIView, UIScrollViewDelegate{
    
    var scoutLabel: BasicLabel!
    var scrollView: UIScrollView!
    
    var autoView: UIView!
    var autoInput: [UISegmentedControl!]!
    
    var teleView: UIView!
    
    var segmentedColor: UIColor!
    
    var teamNumber: Int!
    var roundNumber: Int!
    
    init(teamNumber: Int, roundNumber: Int!, color: UIColor){
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
        self.teamNumber = teamNumber
        self.roundNumber = roundNumber
        
        print("Scouting Round\(self.roundNumber)")
        
        segmentedColor = color
        
        autoInput = []
        
        scoutLabel = BasicLabel(
            frame: self.frame,
            text: "\(teamNumber)",
            fontSize: 80,
            color: UIColor.darkGrayColor(),
            position: CGPoint(
                x: Screen.width/2,
                y: Screen.height/12
            )
        )
        
        //OFFSET SCROLLVIEW
        let svh = 7/32*self.frame.height
    
        scrollView = UIScrollView(frame: CGRectMake(0, svh, self.frame.width, self.frame.height-svh))
        scrollView.delegate = self
        scrollView.directionalLockEnabled = true
        scrollView.pagingEnabled = true
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.Black
        scrollView.contentSize = CGSize(width: self.frame.width * 2, height: self.frame.height-svh)
        scrollView.alpha = 1
        
        //AUTO PANE OF SCROLLVIEW
        autoView = UIView(
            frame: CGRectMake(
                0, 0,
                self.frame.width, self.frame.height
            )
        )
        let autoLabel = BasicLabel(
            frame: self.frame,
            text: "Autonomous",
            fontSize: 50,
            color: UIColor.darkGrayColor(),
            position: CGPoint(
                x: self.frame.width/2,
                y: 0
            )
        )
        
        let names: [String] = ["movedToDefense", "passedDefense", "lowGoal", "highGoal"]
        let labels: [String] = ["Moved to Defense", "Passed Defense", "Low Goal", "High Goal"]
        
        var controlTag = 0
        for i in 0..<names.count {
            let segmentedControl = UISegmentedControl(items: ["True", "False"])
            segmentedControl.selectedSegmentIndex = 1
            
            let attr = NSDictionary(object: UIFont(name: "DINCondensed-Bold", size: 25 * ScreenRatios.screenWidthRatio)!, forKey: NSFontAttributeName)
            UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
            
            segmentedControl.subviews[0].tintColor = segmentedColor
            segmentedControl.subviews[1].tintColor = segmentedColor
            
            segmentedControl.frame = CGRectMake(
                3/5*self.frame.width,
                CGFloat(((1+(Double(1.7)*Double(i)))/10))*self.frame.height,
                1/3*self.frame.width,
                self.frame.width/5
            )
            
            segmentedControl.name = names[i]
            
            let yPos = CGFloat(((1.4+(Double(1.7)*Double(i)))/10))
            let label = BasicLabel(frame: self.frame, text: labels[i], fontSize: 30, color: UIColor.darkGrayColor(), position: CGPoint(x: 1.5/5*self.frame.width, y: yPos*self.frame.height))
            
            segmentedControl.addTarget(self, action: "controlFix:", forControlEvents: .ValueChanged)
            segmentedControl.tag = controlTag
            controlTag += 1
            
            autoInput.append(segmentedControl)
            autoView.addSubview(segmentedControl)
            autoView.addSubview(label)
        }
        

        
        //TELEOP PANE OF SCROLLVIEW
        teleView = UIView(
            frame: CGRectMake(
                self.frame.width, 0,
                self.frame.width, self.frame.height
            )
        )
        
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
        
        //teleLabel.frame.y
        
        let teleVerticalScroller = UIScrollView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
        teleVerticalScroller.delegate = self
        teleVerticalScroller.directionalLockEnabled = true
        teleVerticalScroller.pagingEnabled = true
        teleVerticalScroller.indicatorStyle = UIScrollViewIndicatorStyle.Black
        teleVerticalScroller.contentSize = CGSize(width: self.frame.width, height: 2*self.frame.height)
        teleVerticalScroller.alpha = 1
        
        teleView.addSubview(teleLabel)
        teleView.addSubview(teleVerticalScroller)
//        
//        movedToDefenceControl = UISegmentedControl(items: ["True"])
//        movedToDefenceControl.frame = CGRectMake(1/2*self.frame.width - (movedToDefenceControl.frame.width/2), self.frame.height/2, self.frame.width/2, self.frame.height/10)
//        movedToDefenceControl.setWidth(self.frame.width/3, forSegmentAtIndex: 0)
//        movedToDefenceControl.setWidth(self.frame.width/3, forSegmentAtIndex: 1)
        
        scrollView.addSubview(autoView)
        scrollView.addSubview(teleView)
        
        self.backgroundColor = UIColor.whiteColor()
        
        print("view created for team " + String(teamNumber))
        
        self.addBackButton()
        self.addSubview(scrollView)
        self.addSubview(scoutLabel)
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
    
    func back(){
        self.goBack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}