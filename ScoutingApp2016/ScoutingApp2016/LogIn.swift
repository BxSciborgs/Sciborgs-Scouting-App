//
//  LogIn.swift
//  ScoutingApp
//
//  Created by Oran Luzon on 1/13/16.
//  Copyright © 2016 Oran Luzon. All rights reserved.
//

import UIKit

class LogIn: UIView{
    var user: String!
    var pass: String!
    
    init (username: String, pass: String){
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().nativeBounds.width, height: UIScreen.mainScreen().nativeBounds.height))
        
        // log in code
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}