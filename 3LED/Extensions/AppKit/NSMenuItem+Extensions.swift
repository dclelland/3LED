//
//  NSMenuItem+Extensions.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

extension NSMenuItem {
    
    convenience init(title: String, action: Selector?) {
        self.init(title: title, action: action, keyEquivalent: "")
    }
    
    convenience init(title: String, action: Selector?, submenu: NSMenu) {
        self.init(title: title, action: action, keyEquivalent: "")
        self.submenu = submenu
    }
    
}
