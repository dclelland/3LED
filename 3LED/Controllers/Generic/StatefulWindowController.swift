//
//  StatefulWindowController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class StatefulWindowController<State>: WindowController, Stateful {
    
    var state: State? {
        get {
            return viewController?.state
        }
        set {
            viewController?.state = newValue
            refreshWindow()
        }
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        refreshWindow()
    }
    
    open func refreshWindow(_ state: State) {
        
    }
    
}

extension StatefulWindowController {
    
    var viewController: StatefulViewController<State>? {
        return window?.contentViewController as? StatefulViewController<State>
    }
    
}

extension StatefulWindowController {
    
    final func refreshWindow() {
        if let state = state {
            refreshWindow(state)
        }
    }
    
}
