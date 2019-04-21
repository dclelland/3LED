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
        
        if addresses.value.isEmpty {
            addLight(self)
        }
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
    
    private func refreshMenu() {
        LIFXClient.getConnections(addresses: addresses.value, timeout: 0.25).done { connections in
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
    
    @objc func setLightPower(_ sender: Any?) {
        guard let menuItem = sender as? NSMenuItem, let light = menuItem.representedObject as? Light else {
            return
        }
        
        light.client.light.setPower(on: light.state.power == 0).catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func setLightColor(_ sender: Any?) {
        guard let menuItem = sender as? NSMenuItem, let light = menuItem.representedObject as? Light else {
            return
        }
        
        let windowController = LightWindowController.firstOrInstantiate(state: light)
        windowController.showWindow(self)
    }
    
    @objc func setLightLabel(_ sender: Any?) {
        guard let menuItem = sender as? NSMenuItem, let light = menuItem.representedObject as? Light else {
            return
        }
        
        NSAlert.textField(
            text: .init(
                message: "Set light label"
            ),
            textField: .init(
                text: light.state.label,
                placeholder: "Label"
            ),
            button: .init(
                title: "Set Label"
            )
        ).then { label in
            return light.client.device.setLabel(label: label)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}

extension AppDelegate {
    
    @objc func addLight(_ sender: Any?) {
        NSAlert.textField(
            text: .init(
                message: "Add a light",
                information: "Lights are referenced via their IP address on the local network."
            ),
            textField: .init(
                placeholder: "192.168.0.1"
            ),
            button: .init(
                title: "Add Light"
            )
        ).map { address in
            return String(describing: try IPv4Address(address))
        }.done { address in
            self.addresses.value.removeAll { $0 == address }
            self.addresses.value.append(address)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
    @objc func removeLight(_ sender: Any?) {
        guard let menuItem = sender as? NSMenuItem, let address = menuItem.representedObject as? String else {
            return
        }
        
        NSAlert.action(
            style: .critical,
            text: .init(
                message: "Are you sure you want to remove the light with address \"\(address)\"?"
            ),
            button: .init(
                title: "Remove Light"
            )
        ).done {
            self.addresses.value.removeAll { $0 == address }
        }.cauterize()
    }
    
}

extension AppDelegate {
    
    @objc func toggleLaunchAtLogin(_ sender: Any?) {
        LaunchAtLogin.isEnabled.toggle()
    }
    
}

private extension NSMenuItem {
    
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
                    NSMenuItem(
                        title: "Connected: \(address)",
                        enabled: false
                    ),
                    .separator(),
                    .setLightColor(light: light),
                    .setLightLabel(light: light),
                    .separator(),
                    .removeLight(address: address)
                ]
            )
        )
    }
    
    static func disconnected(address: String, error: Error) -> NSMenuItem {
        return NSMenuItem(
            title: "Unknown",
            state: .mixed,
            submenu: NSMenu(
                items: [
                    NSMenuItem(
                        title: "Disconnected: \(address)",
                        enabled: false
                    ),
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

private extension NSMenuItem {
    
    static func setLightColor(light: Light) -> NSMenuItem {
        return NSMenuItem(
            title: "Set Color...",
            action: #selector(AppDelegate.setLightColor(_:)),
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

private extension NSMenuItem {
    
    static func addLight() -> NSMenuItem {
        return NSMenuItem(
            title: "Add Light...",
            action: #selector(AppDelegate.addLight(_:))
        )
    }
    
    static func removeLight(address: String) -> NSMenuItem {
        return NSMenuItem(
            title: "Remove Light...",
            action: #selector(AppDelegate.removeLight(_:)),
            representedObject: address
        )
    }
    
}

private extension NSMenuItem {
    
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
