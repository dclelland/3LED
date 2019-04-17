//
//  AppDelegate.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Cocoa
import Network
import LIFXClient

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem.button?.image = #imageLiteral(resourceName: "MenuIcon")
        statusItem.button?.action = #selector(showMenu(_:))
        
//        LIFXClient.connect(host: .ipv4(IPv4Address("192.168.1.83")!)).then { client in
//            return client.light.setColor(color: .green)
//        }.done { response in
//            print(response)
//        }.catch { error in
//            print(error)
//        }
    }
    
    @objc func showMenu(_ sender: Any?) {
        print("Show menu")
    }

}
