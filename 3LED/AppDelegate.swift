//
//  AppDelegate.swift
//  3LED
//
//  Created by Daniel Clelland on 18/02/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import UIKit
import Network
import LIFXClient
import PromiseKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LIFXClient.connect(host: .ipv4(IPv4Address("192.168.1.83")!), source: UInt32(1337)).then { client -> Promise<LIFXLight.State> in
            let message = LIFXLight.SetColor(color: LIFXLight.HSBK(hue: 0x4444, saturation: 0xFFFF, brightness: 0xFFFF, kelvin: 3500), duration: 1000)
            return client.light.setColor(message)
        }.done { response in
            print(response)
        }.catch { error in
            print(error)
        }
        
        return true
    }

}
