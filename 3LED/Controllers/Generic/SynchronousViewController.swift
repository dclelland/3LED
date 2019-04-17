//
//  SynchronousViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class SynchronousViewController<State: SynchronousState>: NSViewController, Synchronous {
    
    var state: State? = nil {
        didSet {
            refreshView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshView()
    }
    
    final func refreshView() {
        if let state = state, isViewLoaded {
            refreshView(state: state)
        }
    }
    
    open func refreshView(state: State) {
        
    }
    
}
