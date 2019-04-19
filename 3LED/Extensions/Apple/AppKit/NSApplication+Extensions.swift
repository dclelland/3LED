//
//  NSApplication+Extensions.swift
//  3LED
//
//  Created by Daniel Clelland on 19/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

extension NSApplication {
    
    var windowControllers: [NSWindowController] {
        return windows.compactMap { window in
            return window.windowController
        }
    }
    
}
