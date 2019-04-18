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
    
    var addresses = Persistent<[String]>(
        key: "Addresses",
        value: [
            "192.168.1.83",
            "192.168.1.84"
        ]
    )
    
    let statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem.button?.image = #imageLiteral(resourceName: "MenuIcon")
        
        LIFXClient.getLightStates(addresses: addresses.value).done { results in
            self.statusItem.menu = NSMenu(
                separatedItems: [
                    [
                        NSMenuItem(
                            title: "Lights",
                            submenu: NSMenu(
                                items: results.map { result in
                                    switch result {
                                    case .fulfilled(let state):
                                        return NSMenuItem(
                                            title: state.state.label,
                                            state: state.state.power == 0 ? .off : .on,
                                            action: #selector(AppDelegate.setLightPower(_:)),
                                            representedObject: state,
                                            submenu: NSMenu(
                                                separatedItems: [
                                                    [
                                                        NSMenuItem(
                                                            title: "Set Color...",
                                                            action: #selector(AppDelegate.setLightColor(_:)),
                                                            representedObject: state
                                                        ),
                                                        NSMenuItem(
                                                            title: "Set Waveform...",
                                                            action: #selector(AppDelegate.setLightWaveform(_:)),
                                                            representedObject: state
                                                        ),
                                                        NSMenuItem(
                                                            title: "Set Label...",
                                                            action: #selector(AppDelegate.setLightLabel(_:)),
                                                            representedObject: state
                                                        )
                                                    ],
                                                    [
                                                        NSMenuItem(
                                                            title: "Remove Light",
                                                            action: #selector(AppDelegate.removeLight(_:)),
                                                            representedObject: state
                                                        )
                                                    ]
                                                ]
                                            )
                                        )
                                    case .rejected(let error):
                                        #warning("Display IP address here, also fix 'remove light'")
                                        return NSMenuItem(
                                            title: "Light disconnected",
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
                                                            action: #selector(AppDelegate.removeLight(_:))
                                                        )
                                                    ]
                                                ]
                                            )
                                        )
                                    }
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
        guard let state = sender.representedObject as? LightState else {
            return
        }
        
        switch sender.state {
        case .on:
            state.light.setPower(on: false).catch { error in
                NSAlert(error: error).runModal()
            }
        case .off:
            state.light.setPower(on: true).catch { error in
                NSAlert(error: error).runModal()
            }
        default:
            return
        }
    }
    
    @objc func setLightColor(_ sender: NSMenuItem) {
        guard let state = sender.representedObject as? LightState else {
            return
        }
        
        let windowController = LightColorWindowController.instantiate(state: state)
        windowController.showWindow(self)
    }
    
    @objc func setLightWaveform(_ sender: NSMenuItem) {
        guard let state = sender.representedObject as? LightState else {
            return
        }
        
        let windowController = LightWaveformWindowController.instantiate(state: state)
        windowController.showWindow(self)
    }
    
    @objc func setLightLabel(_ sender: NSMenuItem) {
        
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
        
        alert.runModalPromise().map {
            return try IPv4Address(textField.stringValue)
        }.done { address in
            self.addresses.value.append(String(describing: address))
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func removeLight(_ sender: NSMenuItem) {
        guard let state = sender.representedObject as? LightState else {
            return
        }
        
//        let alert = NSAlert(
//            style: .critical,
//            messageText: "Are you sure you want to remove the light at address \"\(state.address)\"?",
//            actionText: "Remove Light"
//        )
//
//        alert.runModalPromise().done {
//            self.addresses.value.removeAll { address in
//                address == light.address
//            }
//        }
    }
    
}

extension AppDelegate {
    
    @objc func toggleLaunchAtLogin(_ sender: NSMenuItem) {
        LaunchAtLogin.isEnabled.toggle()
    }
    
}
