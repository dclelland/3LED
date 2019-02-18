//
//  AppDelegate.swift
//  3LED
//
//  Created by Daniel Clelland on 18/02/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import UIKit
import LIFXClient

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LIFXClient().connect()
        
        return true
    }

}
