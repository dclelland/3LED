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
        "192.168.1.84",
        "192.168.1.123"
    ]
    
    let statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        #warning("This doesn't time out")
        LIFXClient.getLightStates(addresses: addresses).done { results in
            print(results)
        }
        
        
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
                                        separatedItems: [
                                            [
                                                NSMenuItem(
                                                    title: "Set Color...",
                                                    action: #selector(AppDelegate.setLightColor(_:)),
                                                    representedObject: light
                                                ),
                                                NSMenuItem(
                                                    title: "Set Waveform...",
                                                    action: #selector(AppDelegate.setLightWaveform(_:)),
                                                    representedObject: light
                                                ),
                                                NSMenuItem(
                                                    title: "Set Name...",
                                                    action: #selector(AppDelegate.setLightName(_:)),
                                                    representedObject: light
                                                )
                                            ],
                                            [
                                                NSMenuItem(
                                                    title: "Remove Light",
                                                    action: #selector(AppDelegate.removeLight(_:)),
                                                    representedObject: light
                                                )
                                            ]
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
                        action: #selector(NSApplication.terminate(_:))
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
            return client.light.getState()
        }.done { state in
            let windowController = LightColorWindowController.instantiate(state: state)
            windowController.showWindow(self)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func setLightWaveform(_ sender: NSMenuItem) {
        guard let light = sender.representedObject as? Light else {
            return
        }
        
        LIFXClient.connect(address: light.address).then { client in
            return client.light.getState()
        }.done { state in
            let windowController = LightWaveformWindowController.instantiate(state: state)
            windowController.showWindow(self)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func setLightName(_ sender: NSMenuItem) {
        
    }
    
    @objc func addLight(_ sender: NSMenuItem) {
        let alert = NSAlert(
            messageText: "Add a light",
            informativeText: "Lights are referenced via their IP address on the local network.",
            actionText: "Add Light"
        )
        
        let textField = NSTextField(frame: NSRect(x: 0.0, y: 0.0, width: 240.0, height: 22.0))
        textField.placeholderString = "192.168.0.1"
        
        alert.accessoryView = textField
        alert.runModalPromise().done {
            print("Add light: \(textField.stringValue)")
        }
    }
    
    @objc func removeLight(_ sender: NSMenuItem) {
        guard let light = sender.representedObject as? Light else {
            return
        }
        
        let alert = NSAlert(
            style: .critical,
            messageText: "Are you sure you want to remove the light \"\(light.name)\"?",
            informativeText: "This light has IP address \"\(light.address)\".",
            actionText: "Remove Light"
        )
        
        alert.runModalPromise().done {
            print("Remove \(light.name)")
        }
    }
    
}
