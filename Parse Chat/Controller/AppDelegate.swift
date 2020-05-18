//
//  AppDelegate.swift
//  ParseChat
//
//  Created by Philip Yu on 5/8/19.
//  Copyright © 2019 Philip Yu. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setup Parse
        Parse.initialize(with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) in
            configuration.applicationId = Constant.applicationId
            configuration.server = Constant.server!
        }))
        
        // Stay logged in
        if let currentUser = PFUser.current() {
            print("Welcome back \(currentUser.username!) 😀")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let chatViewController = storyboard.instantiateViewController(withIdentifier: "ChatViewController")
            window?.rootViewController = chatViewController
        }
        
        return true
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) { }
    
    func applicationDidEnterBackground(_ application: UIApplication) { }
    
    func applicationWillEnterForeground(_ application: UIApplication) { }
    
    func applicationDidBecomeActive(_ application: UIApplication) { }
    
    func applicationWillTerminate(_ application: UIApplication) { }
    
}
