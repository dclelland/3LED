//
//  AppDelegate.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Cocoa
import LIFXClient

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem.button?.image = #imageLiteral(resourceName: "MenuIcon")
        statusItem.menu = NSMenu(
            separatedItems: [
                [
                    NSMenuItem(
                        title: "Lights",
                        submenu: NSMenu(
                            items: Light.all.map { light in
                                return NSMenuItem(
                                    title: light.host,
                                    action: #selector(AppDelegate.openLight(_:))
                                )
                            }
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
        LIFXClient.connect(address: sender.title).then { client in
            return client.getLightState()
        }.done { state in
            let windowController = NSWindowController(window: NSWindow(contentViewController: LightViewController.instantiate(state: state)))
            windowController.showWindow(self)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func addLight(_ sender: NSMenuItem) {
        print("Add light")
    }
    
}
