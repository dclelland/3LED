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
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem.button?.image = #imageLiteral(resourceName: "MenuIcon")
        statusItem.menu = NSMenu()
        statusItem.menu?.delegate = self
        
        refreshMenu()
    }

}

extension AppDelegate: NSMenuDelegate {
    
    func menuWillOpen(_ menu: NSMenu) {
        refreshMenu()
    }
    
    func menuDidClose(_ menu: NSMenu) {
        refreshMenu()
    }
    
}

extension AppDelegate {
    
    func refreshMenu() {
        LIFXClient.getConnections(addresses: addresses.value).done { connections in
            self.statusItem.menu?.items = connections.map { connection in
                .connection(connection: connection)
            } + [
                .addLight(),
                .separator(),
                .launchAtLogin(),
                .separator(),
                .quit()
            ]
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
        
        LightColorWindowController.firstOrInstantiate(state: light).showWindow(self)
    }
    
    @objc func setLightWaveform(_ sender: NSMenuItem) {
        guard let light = sender.representedObject as? Light else {
            return
        }
        
        LightWaveformWindowController.firstOrInstantiate(state: light).showWindow(self)
    }
    
    @objc func setLightLabel(_ sender: NSMenuItem) {
        
    }
    
}

extension AppDelegate {
    
    @objc func addLight(_ sender: NSMenuItem) {
        let textField = NSTextField(frame: NSRect(x: 0.0, y: 0.0, width: 240.0, height: 22.0))
        textField.placeholderString = "192.168.0.1"
        
        let alert = NSAlert(
            messageText: "Add a light",
            informativeText: "Lights are referenced via their IP address on the local network.",
            accessoryView: textField,
            actionText: "Add Light"
        )
        
        alert.runModalPromise().map {
            return String(describing: try IPv4Address(textField.stringValue))
        }.done { address in
            self.addresses.value.removeAll { $0 == address }
            self.addresses.value.append(address)
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
        }.cauterize()
    }
    
}

extension AppDelegate {
    
    @objc func toggleLaunchAtLogin(_ sender: NSMenuItem) {
        LaunchAtLogin.isEnabled.toggle()
    }
    
}

extension NSMenuItem {
    
    static func connection(connection: Connection) -> NSMenuItem {
        switch connection {
        case .connected(let address, let light):
            return .connected(address: address, light: light)
        case .disconnected(let address, let error):
            return .disconnected(address: address, error: error)
        }
    }
    
    static func connected(address: String, light: Light) -> NSMenuItem {
        return NSMenuItem(
            title: light.state.label,
            state: light.state.power == 0 ? .off : .on,
            action: #selector(AppDelegate.setLightPower(_:)),
            representedObject: light,
            submenu: NSMenu(
                items: [
                    .setLightColor(light: light),
                    .setLightWaveform(light: light),
                    .setLightLabel(light: light),
                    .separator(),
                    .removeLight(address: address)
                ]
            )
        )
    }
    
    static func disconnected(address: String, error: Error) -> NSMenuItem {
        return NSMenuItem(
            title: address,
            state: .mixed,
            submenu: NSMenu(
                items: [
                    NSMenuItem(
                        title: error.localizedDescription,
                        enabled: false
                    ),
                    .separator(),
                    .removeLight(address: address)
                ]
            )
        )
    }
    
}

extension NSMenuItem {
    
    static func setLightColor(light: Light) -> NSMenuItem {
        return NSMenuItem(
            title: "Set Color...",
            action: #selector(AppDelegate.setLightColor(_:)),
            representedObject: light
        )
    }
    
    static func setLightWaveform(light: Light) -> NSMenuItem {
        return NSMenuItem(
            title: "Set Waveform...",
            action: #selector(AppDelegate.setLightWaveform(_:)),
            representedObject: light
        )
    }
    
    static func setLightLabel(light: Light) -> NSMenuItem {
        return NSMenuItem(
            title: "Set Label...",
            action: #selector(AppDelegate.setLightLabel(_:)),
            representedObject: light
        )
    }
    
}

extension NSMenuItem {
    
    static func addLight() -> NSMenuItem {
        return NSMenuItem(
            title: "Add Light...",
            action: #selector(AppDelegate.addLight(_:))
        )
    }
    
    static func removeLight(address: String) -> NSMenuItem {
        return NSMenuItem(
            title: "Remove Light",
            action: #selector(AppDelegate.removeLight(_:)),
            representedObject: address
        )
    }
    
}

extension NSMenuItem {
    
    static func launchAtLogin() -> NSMenuItem {
        return NSMenuItem(
            title: "Launch at Login",
            state: LaunchAtLogin.isEnabled ? .on : .off,
            action: #selector(AppDelegate.toggleLaunchAtLogin(_:))
        )
    }
    
    static func quit() -> NSMenuItem {
        return NSMenuItem(
            title: "Quit \(Bundle.main.name)",
            action: #selector(NSApplication.terminate(_:))
        )
    }
    
}
