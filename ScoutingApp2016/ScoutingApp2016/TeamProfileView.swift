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
    
    init(teamName: String, json: JSON) {
        super.init(frame: Screen.frame)
        
        //get information from parse
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Done, target: self, action: "back")
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = nil
        
        // Assign the navigation item to the navigation bar
        (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.items = [navigationItem]
        
        title = BasicLabel(frame: Screen.frame, text: teamName, fontSize: 60, color: UIColor.darkGrayColor(), position: CGPoint(x: Screen.width/2, y: Screen.width/8))
        
        self.addSubview(title)
    }
    
    func back(){
        UIApplication.sharedApplication().keyWindow?.rootViewController!.view.insertSubview(ViewTeamView(), belowSubview: (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar)
        self.removeFromSuperview()
        (UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController).navBar.items = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
