//
//  ViewController.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/13/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit
//import GoogleSignIn/GoogleSignIn.h

public struct Screen{
    static let width = UIScreen.mainScreen().bounds.width
    static let height = UIScreen.mainScreen().bounds.height
    static let frame = CGRect(x: 0, y: 0, width: width, height: height)
}

class ViewController: UIViewController, GIDSignInUIDelegate, UINavigationBarDelegate {

    var button: GIDSignInButton!
    //var pickMode: PickModeView!
    var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        button = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: Screen.width/*200*/, height: 21))
        button.center = CGPoint(x: Screen.width/2, y: Screen.height - button.frame.height/2)
        button.enabled = true
        
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        
        
        
        
        //view.addSubview(button)
        view.addSubview(HomeView())
        //view.addSubview(TeamPickerView(frame: self.view.frame, blueTeams: [1155,2265,3342], redTeams: [1342,2534,2343]))

        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: Screen.width, height: 44))
        navBar.delegate = self;
        
        
        if (!GIDSignIn.sharedInstance().hasAuthInKeychain()){
            view.addSubview(button)
        }
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        view.addSubview(navBar)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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

