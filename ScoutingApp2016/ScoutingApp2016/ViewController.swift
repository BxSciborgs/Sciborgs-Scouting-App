//
//  ViewController.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/13/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit
//import GoogleSignIn/GoogleSignIn.h

class ViewController: UIViewController, GIDSignInUIDelegate {

    var button: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()     
        
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        button = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        button.center = CGPoint(x: width/2, y: height/2)
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        view.addSubview(button)
        print("done")
    }
    
    
    
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        
    }
    
    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        
    }
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

