//
//  HomeView.swift
//  ScoutingApp2016
//
//  Created by Yoli Meydan on 1/26/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import Foundation
import UIKit

public struct ScreenRatios {
    static var screenWidth = UIScreen.mainScreen().bounds.size.width
    static var screenWidthRatio = screenWidth/375
    
    static var screenHeight = UIScreen.mainScreen().bounds.size.height
    static var screenHeightRatio = screenHeight/667
    
    static var screenRatio = screenWidth/screenHeight
}


class HomeView: UIView {
    
    var banner: UIImageView!

    var viewButton: BasicButton!
    var scoutButton: BasicButton!
    
    var teamNumberButton: BasicButton?
    
    var teamNumberField: UITextField?
    
    var addTeamView: UIView?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        frame = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
        
        viewButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor.lightGrayColor(), size: CGRect(x: 0, y: 0, width: frame.width/1.5, height: frame.width/3), location: CGPoint(x: frame.width/2,y: frame.height/2), title: "REVIEW", titleSize: 80)
        viewButton.addTarget(self, action: "viewTeams", forControlEvents: UIControlEvents.TouchUpInside)
        
        scoutButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor.lightGrayColor(), size: CGRect(x: 0, y: 0, width: frame.width/1.5, height: frame.width/3), location: CGPoint(x: frame.width/2,y: 3*frame.height/4), title: "SCOUT", titleSize: 80)
        scoutButton.addTarget(self, action: "scoutView", forControlEvents: UIControlEvents.TouchUpInside)
        
        banner = UIImageView(image: UIImage(named: "Banner"))
        let newImage = banner.image!.scaleUIImageToSize(banner.image!, size: CGSize(width: self.frame.width,height: self.frame.height/3.5))
        let imageView = UIImageView(image: newImage)
        imageView.center = CGPoint(x: self.frame.width/2,y: self.frame.height/5)
        
        //self.addBackButton()
        
        self.addSubview(viewButton)
        self.addSubview(scoutButton)
        self.addSubview(imageView)
        //self.addSubview(sciborgsLabelTop)
        //self.addSubview(sciborgsLabelBottom)
        
        //TESTING
        //NSUserDefaults().setObject(nil, forKey: "TeamNumber")
        
        if (NSUserDefaults().objectForKey("TeamNumber") == nil) {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
            self.addGestureRecognizer(tap)
            
            print("Creating")
            addTeamView = UIView(frame: CGRect(x: 0, y: Screen.height/2-55, width: Screen.width, height: Screen.height/2+55))
            addTeamView!.backgroundColor = UIColor.whiteColor()
            
            teamNumberField = UITextField(
                frame: CGRectMake(
                    Screen.width/2-100,
                    Screen.height/2,
                    500,
                    44
                )
            )
            
            teamNumberButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor.lightGrayColor(), size: CGRect(x: 0, y: 0, width: frame.width/1.5, height: frame.width/3), location: CGPoint(x: frame.width/2,y: 3*frame.height/4), title: "ENTER", titleSize: 80)
            teamNumberButton!.addTarget(self, action: "teamNumEnter", forControlEvents: UIControlEvents.TouchUpInside)
            
            teamNumberField!.placeholder = "Team number here..."
            teamNumberField!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
            
            self.addSubview(addTeamView!)
            self.addSubview(teamNumberField!)
            self.addSubview(teamNumberButton!)
        }
        
    }
    
<<<<<<< HEAD
    func back(){
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status
        self.endEditing(true)
    }
    
=======
>>>>>>> f722d74a59f487f58c9dbe07852893d407b1639f
    // Adds the ViewTeams View
    func viewTeams(){
        self.launchViewOnTop(TeamSelectionView())
    }
    
    // Adds the Scouting View
    func scoutView(){
        self.launchViewOnTop(RoundSelectionView())
    }
    
    func teamNumEnter() {
        if (teamNumberField!.text != "") {
            let n = Int(teamNumberField!.text!)
            NSUserDefaults().setInteger(n!, forKey: "TeamNumber")
            addTeamView!.removeFromSuperview()
            teamNumberField!.removeFromSuperview()
            teamNumberButton!.removeFromSuperview()
            print(n)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    func scaleUIImageToSize(let image: UIImage, let size: CGSize) -> UIImage {
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}