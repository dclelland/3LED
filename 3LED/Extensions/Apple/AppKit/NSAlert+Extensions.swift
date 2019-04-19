//
//  NSAlert+Extensions.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import PromiseKit

extension NSAlert {
    
    convenience init(style: NSAlert.Style = .informational, messageText: String = "", informativeText: String = "", accessoryView: NSView? = nil) {
        self.init()
        self.alertStyle = style
        self.messageText = messageText
        self.informativeText = informativeText
        self.accessoryView = accessoryView
    }
    
    convenience init(style: NSAlert.Style = .informational, messageText: String = "", informativeText: String = "", accessoryView: NSView? = nil, actionText: String) {
        self.init(style: style, messageText: messageText, informativeText: informativeText, accessoryView: accessoryView)
        self.addButton(withTitle: actionText)
        self.addButton(withTitle: "Cancel")
    }
    
}

extension NSAlert {
    
    func runModalPromise() -> Promise<Void> {
        return Promise { resolver in
            switch runModal() {
            case .alertFirstButtonReturn:
                resolver.fulfill(())
            default:
                resolver.reject(PMKError.cancelled)
            }
        }
    }
    
}
