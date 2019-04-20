//
//  NSScreen+Extensions.swift
//  3LED
//
//  Created by Daniel Clelland on 21/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

extension NSScreen {
    
    var desktopFrame: NSRect {
        return frame.divided(atDistance: NSApplication.shared.menu?.menuBarHeight ?? 0.0, from: .maxYEdge).remainder
    }
    
}
