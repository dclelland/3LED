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
        statusItem.menu = NSMenu(
            separatedItems: [
                [
                    .init(title: "Add light...", action: #selector(AppDelegate.addLight(_:)), keyEquivalent: "a")
                ],
                [
                    .init(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
                ]
            ]
        )
    }
    
    @objc func addLight(_ sender: Any?) {
        print("Add light")
    }

}
