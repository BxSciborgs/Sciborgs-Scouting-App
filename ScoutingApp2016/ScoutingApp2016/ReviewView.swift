//
//  TeleOpSubview.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 2/1/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class ReviewView: UIView{
    
    var submitColor: UIColor!
    var submitButton: UIButton!
    
    init(submitColor: UIColor){
        super.init(frame:
            CGRectMake(
                Screen.width * 2, 0,
                Screen.width, Screen.height
            )
        )
        
        self.submitColor = submitColor
        
        submitButton = BasicButton(
            type: UIButtonType.RoundedRect,
            color: submitColor,
            size: CGRect(x: 0, y: 0, width: self.frame.width/2, height: self.frame.height/5),
            location: CGPoint(x: self.frame.width/2, y: (1/4)*self.frame.height),
            title: "Submit",
            titleSize: 50)
        
        
        self.addSubview(submitButton)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
