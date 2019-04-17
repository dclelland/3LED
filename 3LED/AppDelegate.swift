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
                    NSMenuItem(
                        title: "Lights",
                        submenu: NSMenu(
                            items: [
                                NSMenuItem(
                                    title: "192.168.1.83",
                                    action: #selector(AppDelegate.openLight(_:))
                                ),
                                NSMenuItem(
                                    title: "192.168.1.84",
                                    action: #selector(AppDelegate.openLight(_:))
                                )
                            ]
                        )
                    ),
                    NSMenuItem(
                        title: "Add Light...",
                        action: #selector(AppDelegate.addLight(_:)),
                        keyEquivalent: "l"
                    )
                ],
                [
                    NSMenuItem(
                        title: "Quit \(Bundle.main.name)",
                        action: #selector(NSApplication.terminate(_:)),
                        keyEquivalent: "q"
                    )
                ]
            ]
        )
    }

}

extension AppDelegate {
    
    @objc func openLight(_ sender: NSMenuItem) {
        let light = Light(name: "Test", host: sender.title)
        let windowController = NSWindowController(window: NSWindow(contentViewController: LightViewController.instantiate(input: light)))
        windowController.showWindow(self)
    }
    
    @objc func addLight(_ sender: NSMenuItem) {
        print("Add light")
    }
    
}
