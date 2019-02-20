//
//  AppDelegate.swift
//  3LED
//
//  Created by Daniel Clelland on 18/02/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import UIKit
import LIFXClient
import Network

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var client = LIFXClient(address: IPv4Address("192.168.1.83")!, source: 1234)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        client.connect()
        
        return true
    }

}
