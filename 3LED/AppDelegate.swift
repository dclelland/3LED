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
import LaunchAtLogin

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {
    
    var addresses = Persistent<[String]>(key: "Addresses", value: [])
    
    let statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem.button?.image = #imageLiteral(resourceName: "MenuIcon")
        
        LIFXClient.getConnections(addresses: addresses.value).done { connections in
            self.statusItem.menu = NSMenu(
                separatedItems: [
                    connections.map { connection in
                        switch connection {
                        case .connected(let address, let light):
                            return NSMenuItem(
                                title: light.state.label,
                                state: light.state.power == 0 ? .off : .on,
                                action: #selector(AppDelegate.setLightPower(_:)),
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
                                                title: "Set Label...",
                                                action: #selector(AppDelegate.setLightLabel(_:)),
                                                representedObject: light
                                            )
                                        ],
                                        [
                                            NSMenuItem(
                                                title: "Remove Light",
                                                action: #selector(AppDelegate.removeLight(_:)),
                                                representedObject: address
                                            )
                                        ]
                                    ]
                                )
                            )
                        case .disconnected(let address, let error):
                            return NSMenuItem(
                                title: address,
                                state: .mixed,
                                submenu: NSMenu(
                                    separatedItems: [
                                        [
                                            NSMenuItem(
                                                title: error.localizedDescription,
                                                enabled: false
                                            )
                                        ],
                                        [
                                            NSMenuItem(
                                                title: "Remove Light",
                                                action: #selector(AppDelegate.removeLight(_:)),
                                                representedObject: address
                                            )
                                        ]
                                    ]
                                )
                            )
                        }
                    } + [
                        NSMenuItem(
                            title: "Add Light...",
                            action: #selector(AppDelegate.addLight(_:))
                        )
                    ],
                    [
                        NSMenuItem(
                            title: "Launch at Login",
                            state: LaunchAtLogin.isEnabled ? .on : .off,
                            action: #selector(AppDelegate.toggleLaunchAtLogin(_:))
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

}

extension AppDelegate {
    
    @objc func setLightPower(_ sender: NSMenuItem) {
        guard let light = sender.representedObject as? Light else {
            return
        }
        
        switch sender.state {
        case .on:
            light.client.light.setPower(on: false).catch { error in
                NSAlert(error: error).runModal()
            }
        case .off:
            light.client.light.setPower(on: true).catch { error in
                NSAlert(error: error).runModal()
            }
        default:
            return
        }
    }
    
    @objc func setLightColor(_ sender: NSMenuItem) {
        guard let light = sender.representedObject as? Light else {
            return
        }
        
        let windowController = LightColorWindowController.instantiate(state: light)
        windowController.showWindow(self)
    }
    
    @objc func setLightWaveform(_ sender: NSMenuItem) {
        guard let light = sender.representedObject as? Light else {
            return
        }
        
        let windowController = LightWaveformWindowController.instantiate(state: light)
        windowController.showWindow(self)
    }
    
    @objc func setLightLabel(_ sender: NSMenuItem) {
        
    }
    
}

extension AppDelegate {
    
    @objc func addLight(_ sender: NSMenuItem) {
        let alert = NSAlert(
            messageText: "Add a light",
            informativeText: "Lights are referenced via their IP address on the local network.",
            actionText: "Add Light"
        )
        
        let textField = NSTextField(frame: NSRect(x: 0.0, y: 0.0, width: 240.0, height: 22.0))
        textField.placeholderString = "192.168.0.1"
        alert.accessoryView = textField
        
        alert.runModalPromise().map {
            return try IPv4Address(textField.stringValue)
        }.done { address in
            self.addresses.value.append(String(describing: address))
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func removeLight(_ sender: NSMenuItem) {
        guard let address = sender.representedObject as? String else {
            return
        }
        
        let alert = NSAlert(
            style: .critical,
            messageText: "Are you sure you want to remove the light with address \"\(address)\"?",
            actionText: "Remove Light"
        )

        alert.runModalPromise().done {
            self.addresses.value.removeAll { $0 == address }
        }
    }
    
}

extension AppDelegate {
    
    @objc func toggleLaunchAtLogin(_ sender: NSMenuItem) {
        LaunchAtLogin.isEnabled.toggle()
    }
    
}
