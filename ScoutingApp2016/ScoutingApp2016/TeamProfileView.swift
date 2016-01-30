//
//  TeamProfileView.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/26/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class TeamProfileView: UIView{
    
    var title: UILabel!
    var teamNumber: Int!
    
    init(teamNumber: Int, json: JSON) {
        super.init(frame: Screen.frame)
        
        self.teamNumber = teamNumber
        
        self.addBackButton()
        
        title = BasicLabel(frame: Screen.frame, text: "Team\(teamNumber)", fontSize: 60, color: UIColor.darkGrayColor(), position: CGPoint(x: Screen.width/2, y: Screen.height/12))
        
        self.addSubview(title)
    }
    
    func back(){
        (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.items = nil
        UIApplication.sharedApplication().keyWindow?.rootViewController!.view.insertSubview(TeamSelectionView(), belowSubview: (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar)
        self.removeFromSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
