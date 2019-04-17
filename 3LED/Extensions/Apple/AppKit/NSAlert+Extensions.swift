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
    
    convenience init(message: String) {
        self.init()
        self.alertStyle = .informational
        self.messageText = message
    }
    
    convenience init(prompt message: String, buttonTitle: String) {
        self.init(message: message)
        self.alertStyle = .critical
        self.addButton(withTitle: buttonTitle)
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
