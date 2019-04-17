//
//  SynchronousViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class SynchronousViewController<State: SynchronousState>: NSViewController, Synchronous {
    
    var state: State = .init() {
        didSet {
            refreshView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshView()
    }
    
    final func refreshView() {
        guard isViewLoaded else {
            return
        }
        
        refreshView(state)
    }
    
    open func refreshView(_ state: State) {
        fatalError("Override `refreshView(state:)` in subclasses")
    }
    
}
