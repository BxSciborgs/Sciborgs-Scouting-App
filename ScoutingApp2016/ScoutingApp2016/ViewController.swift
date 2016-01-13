//
//  ViewController.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/13/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label: UILabel!
    var userField: UITextField!
    var passField: UITextField!
    var submit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: width/2, y:  height/4)
        label.textAlignment = NSTextAlignment.Center
        label.text = "Log In"
        
        userField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        userField.center = CGPoint(x: width/2, y:  height/2)
        userField.textAlignment = NSTextAlignment.Center
        userField.tintColor = UIColor.blackColor()
        userField.borderRectForBounds(CGRect(x: 0, y: 0, width: 200, height: 21))
        userField.borderStyle = UITextBorderStyle.RoundedRect
        
        passField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        passField.center = CGPoint(x: width/2, y:  height/2 + height/8)
        passField.textAlignment = NSTextAlignment.Center
        passField.tintColor = UIColor.blackColor()
        passField.borderRectForBounds(CGRect(x: 0, y: 0, width: 200, height: 21))
        passField.borderStyle = UITextBorderStyle.RoundedRect
        
        submit = UIButton(type: UIButtonType.RoundedRect)
        submit.center = CGPoint(x: width/2, y:  height/2 + 2 * height/8)
        submit.setTitle("Submit", forState: UIControlState.Normal)
        submit.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        
        view.addSubview(label)
        view.addSubview(userField)
        view.addSubview(passField)
        view.addSubview(submit)
        print("done")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

