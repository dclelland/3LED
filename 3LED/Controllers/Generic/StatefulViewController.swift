//
//  StatefulViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class StatefulViewController<State>: NSViewController, Stateful {
    
    var state: State? {
        didSet {
            refreshView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshView()
    }
    
    open func refreshView(_ state: State) {
        
    }
    
}

extension StatefulViewController {
    
    final func refreshView() {
        if let state = state, isViewLoaded {
            refreshView(state)
        }
    }
    
}
