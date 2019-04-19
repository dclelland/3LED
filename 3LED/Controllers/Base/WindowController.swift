//
//  WindowController.swift
//  3LED
//
//  Created by Daniel Clelland on 19/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class WindowController: NSWindowController {
    
    private var retainCycle: NSWindowController?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.delegate = self
    }
    
    override func showWindow(_ sender: Any?) {
        super.showWindow(sender)
        retainCycle = self
    }
    
}

extension WindowController: NSWindowDelegate {
    
    func windowWillClose(_ notification: Notification) {
        retainCycle = nil
    }
    
}
