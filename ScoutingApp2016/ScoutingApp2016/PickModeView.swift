
//
//  File.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class PickModeView: UIView{
 
    var scoutButton: UIButton!
    var viewTeamsButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        self.backgroundColor = UIColor.whiteColor()
        
        scoutButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor(red: 238/255, green: 238/255, blue: 34/255, alpha: 1), size: CGRect(x: 0, y: 0, width: 150, height: 44), location: CGPoint(x: width/2, y: height/8 * 6), title: "Scout")
        scoutButton.addTarget(self, action: Selector("goToScout"), forControlEvents: UIControlEvents.TouchUpInside)
        
        viewTeamsButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor(red: 238/255, green: 238/255, blue: 34/255, alpha: 1), size: CGRect(x: 0, y: 0, width: 150, height: 44), location: CGPoint(x: width/2, y: height/8 * 2), title: "View Teams")
        viewTeamsButton.addTarget(self, action: Selector("goToViewTeams"), forControlEvents: UIControlEvents.TouchUpInside)
        
        print("Created")
        addSubview(scoutButton)
        addSubview(viewTeamsButton)
    }

    func goToScout(){
        UIApplication.sharedApplication().keyWindow?.rootViewController!.view.addSubview(ScoutView())
        self.removeFromSuperview()
    }
    
    func goToViewTeams(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}