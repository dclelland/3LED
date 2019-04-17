//
//  NSMenu+Extensions.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

extension NSMenu {
    
    convenience init(title: String = "", items: [NSMenuItem]) {
        self.init(title: title)
        self.items = items
    }
    
    convenience init(title: String = "", separatedItems: [[NSMenuItem]]) {
        self.init(title: title)
        self.items = Array(separatedItems.joined(separator: [NSMenuItem.separator()]))
    }
    
}
