//
//  AppDelegate.swift
//  ScoutingApp2016
//
//  Created by Oran Luzon on 1/13/16.
//  Copyright © 2016 Sciborgs. All rights reserved.
//

import UIKit
import Bolts
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Initialize sign-in
        
        Parse.enableLocalDatastore()
        
        Parse.setApplicationId("KBqIB66cUvbVxjCLMQw1ug3AiTdldkjoDKlhpGuo",
            clientKey: "EmsYKeBWl79WGbAdhtjWUUYCyJuL7iABao5lbzcM")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        GIDSignIn.sharedInstance().clientID = "1008849373609-v4eaemodfnc4sku53c8fonjtka7fugn2.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        let orch = options as! [String: String]
        return GIDSignIn.sharedInstance().handleURL(url, sourceApplication:
            orch[UIApplicationOpenURLOptionsSourceApplicationKey],
            annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
        
        //return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey],annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }

    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        //do something
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        //do something
<<<<<<< HEAD
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let name = user.profile.name
            let email = user.profile.email
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
=======
>>>>>>> be7ada88728fa20f31d252c88328c2deb26b3db7
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

