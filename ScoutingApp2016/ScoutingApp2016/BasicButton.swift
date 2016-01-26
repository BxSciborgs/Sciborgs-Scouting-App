//
//  BasicButton.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/15/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class BasicButton: UIButton{

    var button: UIButton!
    
    init(type: UIButtonType, color: UIColor, size: CGRect, location: CGPoint, title: String, titleSize: Int){
        //super.init(type: UIButtonType.RoundedRect)
        super.init(frame: size)
        button = UIButton(type: UIButtonType.RoundedRect)
        
        //let width = UIScreen.mainScreen().bounds.width
        //let height = UIScreen.mainScreen().bounds.height
        
        let yellowColor = UIColor(red: 0.98, green: 0.95, blue: 0.55, alpha: 1)

        self.frame = size
        self.center = location
        self.setTitle(title, forState: UIControlState.Normal)
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.clearColor()
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = 3
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    
        self.titleLabel!.font = UIFont(name: "DINCondensed-Bold", size: CGFloat(titleSize) * ScreenRatios.screenWidthRatio)
        self.titleLabel!.textAlignment = NSTextAlignment.Center
        self.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        self.contentEdgeInsets = UIEdgeInsets(top: self.titleLabel!.intrinsicContentSize().height/4, left: 0, bottom: 0, right: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}