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
    
    var addresses: [String] = [
        "192.168.1.83",
        "192.168.1.84"
    ]
    
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
                                    title: light.name,
                                    state: light.powered ? .on : .off,
                                    action: #selector(AppDelegate.toggleLight(_:)),
                                    representedObject: light,
                                    submenu: NSMenu(
                                        items: [
                                            NSMenuItem(
                                                title: "Set Color...",
                                                action: #selector(AppDelegate.setLightColor(_:)),
                                                representedObject: light
                                            ),
                                            NSMenuItem(
                                                title: "Set Gradient...",
                                                action: #selector(AppDelegate.setLightGradient(_:)),
                                                representedObject: light
                                            ),
                                            NSMenuItem(
                                                title: "Set Name...",
                                                action: #selector(AppDelegate.setLightName(_:)),
                                                representedObject: light
                                            )
                                        ]
                                    )
                                )
                            }
                        )
                    ),
                    NSMenuItem(
                        title: "Add Light...",
                        action: #selector(AppDelegate.addLight(_:))
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
    
    @objc func openMenu(_ sender: NSStatusItem) {
        
    }
    
}

extension AppDelegate {
    
    @objc func toggleLight(_ sender: NSMenuItem) {
        guard let light = sender.representedObject as? Light else {
            return
        }
        
        LIFXClient.connect(address: light.address).then { client in
            client.light.setPower(on: sender.state == .off)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func setLightColor(_ sender: NSMenuItem) {
        guard let light = sender.representedObject as? Light else {
            return
        }
        
        LIFXClient.connect(address: light.address).then { client in
            return client.getLightState()
        }.done { state in
            let windowController = NSWindowController(window: NSWindow(contentViewController: LightViewController.instantiate(state: state)))
            windowController.showWindow(self)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func setLightGradient(_ sender: NSMenuItem) {
        
    }
    
    @objc func setLightName(_ sender: NSMenuItem) {
        
    }
    
    @objc func addLight(_ sender: NSMenuItem) {
        print("Add light")
    }
    
}
