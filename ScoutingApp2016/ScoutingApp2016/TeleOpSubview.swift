//
//  TeleOpSubview.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 2/1/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class TeleOpSubview: UIView{
    
    init(superView: UIView){
        super.init(frame:
            CGRectMake(
                Screen.width, 0,
                Screen.width, Screen.height
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
    
        print("Screen Height: \(self.frame.height) \(Screen.height) \n height: " + String(self.frame.height-bsConstants.pjl))
        
        let teleVerticalScroller = UIScrollView(frame: CGRect(x: 0, y: bsConstants.pjl, width: self.frame.width, height: self.frame.height-(bsConstants.pjl+bsConstants.svh)))
        teleVerticalScroller.delegate = (superView as! UIScrollViewDelegate)
        teleVerticalScroller.directionalLockEnabled = true
        teleVerticalScroller.indicatorStyle = UIScrollViewIndicatorStyle.Black
        teleVerticalScroller.contentSize = CGSize(width: self.frame.width, height: 2*teleVerticalScroller.frame.height)
        teleVerticalScroller.alpha = 1
        
        self.addSubview(teleLabel)
        self.addSubview(teleVerticalScroller)
        //
        //        movedToDefenceControl = UISegmentedControl(items: ["True"])
        //        movedToDefenceControl.frame = CGRectMake(1/2*self.frame.width - (movedToDefenceControl.frame.width/2), self.frame.height/2, self.frame.width/2, self.frame.height/10)
        //        movedToDefenceControl.setWidth(self.frame.width/3, forSegmentAtIndex: 0)
        //        movedToDefenceControl.setWidth(self.frame.width/3, forSegmentAtIndex: 1)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
