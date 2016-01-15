//
//  Matches.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/13/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit

class matches: UIViewController{
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: width/2, y:  height/4)
        label.textAlignment = NSTextAlignment.Center
    }
}
