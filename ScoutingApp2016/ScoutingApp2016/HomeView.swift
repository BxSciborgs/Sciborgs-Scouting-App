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
    
    var sciborgsLabelTop: BasicLabel!
    var sciborgsLabelBottom: BasicLabel!
    
    var banner: UIImageView!

    var viewButton: BasicButton!
    var scoutButton: BasicButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sciborgsLabelTop = BasicLabel(frame: frame, text: "SCIBORGS", fontSize: 75, color: UIColor.darkGrayColor(), position: CGPoint(x: frame.width/2, y: frame.height/15))
        sciborgsLabelBottom = BasicLabel(frame: frame, text: "SCOUTING APP", fontSize: 70, color: UIColor.darkGrayColor(), position: CGPoint(x: frame.width/2, y: frame.height/5.5))
        
        viewButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor.lightGrayColor(), size: CGRect(x: 0, y: 0, width: frame.width/1.5, height: frame.width/3), location: CGPoint(x: frame.width/2,y: frame.height/2), title: "VIEW", titleSize: 80)
        
        scoutButton = BasicButton(type: UIButtonType.RoundedRect, color: UIColor.lightGrayColor(), size: CGRect(x: 0, y: 0, width: frame.width/1.5, height: frame.width/3), location: CGPoint(x: frame.width/2,y: 3*frame.height/4), title: "SCOUT", titleSize: 80)
        
        banner = UIImageView(image: UIImage(named: "Banner"))
        let newImage = banner.image!.scaleUIImageToSize(banner.image!, size: CGSize(width: self.frame.width,height: self.frame.height/3.5))
        let imageView = UIImageView(image: newImage)
        imageView.center = CGPoint(x: self.frame.width/2,y: self.frame.height/5)

        
        self.addSubview(viewButton)
        self.addSubview(scoutButton)
        self.addSubview(imageView)
        //self.addSubview(sciborgsLabelTop)
        //self.addSubview(sciborgsLabelBottom)
    }
    
    func addLabel(frame: CGRect, text: String, fontSize: Int!, color: UIColor, center: CGPoint) {
        let myLabel = UILabel(frame: CGRectMake(0,0,0,0))
        myLabel.text = text
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.textColor = color
        myLabel.font = UIFont(name: "DINCondensed-Bold", size: CGFloat(fontSize) * ScreenRatios.screenWidthRatio)
        myLabel.center = CGPoint(x: center.x - (myLabel.intrinsicContentSize().width/2), y: center.y)
        myLabel.sizeToFit()
        
        self.addSubview(myLabel)
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