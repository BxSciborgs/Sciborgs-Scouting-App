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
    
    init(type: UIButtonType, color: UIColor, size: CGRect, location: CGPoint, title: String){
        //super.init(type: UIButtonType.RoundedRect)
        super.init(frame: size)
        button = UIButton(type: UIButtonType.RoundedRect)
        
        //let width = UIScreen.mainScreen().bounds.width
        //let height = UIScreen.mainScreen().bounds.height
        
        frame = size
        center = location
        setTitle(title, forState: UIControlState.Normal)
        layer.cornerRadius = 10
        backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 34/255, alpha: 1)
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        let scalingFactor = min(self.frame.width / frame.width, self.frame.height / frame.height)/0.8
        titleLabel!.font = UIFont(name: "DINCondensed-Bold", size: titleLabel!.font.pointSize * CGFloat(scalingFactor))
        titleLabel!.textAlignment = NSTextAlignment.Center
        contentEdgeInsets = UIEdgeInsets(top: frame.height/5, left: 0, bottom: 0, right: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}