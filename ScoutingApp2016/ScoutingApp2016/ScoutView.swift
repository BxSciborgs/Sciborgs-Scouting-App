//
//  ScoutView.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class ScoutView: UIView, UIScrollViewDelegate{
    
    var scoutLabel: BasicLabel!
    var scrollView: UIScrollView!
    
    var autoView: UIView!
    var teleView: UIView!
    
    init(teamNumber: Int){
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        
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
        
        let svh = 7/32*self.frame.height
    
        scrollView = UIScrollView(frame: CGRectMake(0, svh, self.frame.width, self.frame.height-svh))
        scrollView.delegate = self
        scrollView.directionalLockEnabled = true
        scrollView.pagingEnabled = true
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.Black
        scrollView.contentSize = CGSize(width: self.frame.width * 2, height: self.frame.height-svh)
        scrollView.alpha = 1
        
        autoView = UIView(
            frame: CGRectMake(
                0, 0,
                self.frame.width, self.frame.height
            )
        )
        
        teleView = UIView(
            frame: CGRectMake(
                self.frame.width, 0,
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
        
        autoView.addSubview(autoLabel)
        teleView.addSubview(teleLabel)
        
        scrollView.addSubview(autoView)
        scrollView.addSubview(teleView)
        
        self.backgroundColor = UIColor.whiteColor()
        
        print("view created for team " + String(teamNumber))
        
        self.addBackButton()
        self.addSubview(scrollView)
        self.addSubview(scoutLabel)
    }

    func back(){
        
        removeFromSuperview()
        //self.lauchView(TeamPickerView(blueTeams: <#T##[Int]#>, redTeams: <#T##[Int]#>))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}