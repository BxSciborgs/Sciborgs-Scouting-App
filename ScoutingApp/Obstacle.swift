
//
//  File.swift
//  ScoutingApp
//
//  Created by Oran Luzon on 1/12/16.
//  Copyright © 2016 Oran Luzon. All rights reserved.
//

import UIKit

class Obstacle: UIView{
    
    var name: String!
    
    var nameLabel: UILabel!
    var scoreLabel: UILabel!
    
    var stepper: UIStepper!
    
    var image: UIImage!
    
    init(name: String){
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().nativeBounds.width, height: UIScreen.mainScreen().nativeBounds.height))
        
        self.name = name
        add()
    }
    
    init(name: String, image: UIImage){
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().nativeBounds.width, height: UIScreen.mainScreen().nativeBounds.height))
        
        self.image = image
        
        self.name = name
        add()
    }
    
    func add() {
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        stepper = UIStepper(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        stepper.center = CGPoint(x: 2 * width/4 + stepper.frame.width * 0.1, y: height/8 + height/16)
        stepper.autorepeat = false
        stepper.addTarget(UIApplication.sharedApplication().keyWindow?.rootViewController!, action: Selector("changeVal"), forControlEvents: UIControlEvents.TouchUpInside)
        stepper.maximumValue = 10
        stepper.continuous = false
        
        scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        scoreLabel.center = CGPoint(x: 2 * width/4 + stepper.frame.width * 0.1, y: height/8)
        scoreLabel.textAlignment = NSTextAlignment.Center
        scoreLabel.text = "0"
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        nameLabel.center = CGPoint(x: 2 * width/4 + stepper.frame.width * 0.1, y: height/8 - height/16)
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.text = name
        
        if (image != nil){
            let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
            imageView.image = image
            imageView.center = CGPoint(x: width/4, y: height/8)
            addSubview(imageView)
        }
        
        
        addSubview(scoreLabel)
        addSubview(stepper)
        addSubview(nameLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeVal(){
        print(stepper.value)
        scoreLabel.text = String(Int(stepper.value))
    }
    
}




