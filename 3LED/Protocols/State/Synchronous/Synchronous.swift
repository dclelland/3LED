//
//  Synchronous.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

protocol Synchronous: class {
    
    associatedtype State
    
    var state: State? { get set }
    
    func refreshView(_ state: State)
    
}

extension Synchronous where Self: NSViewController {
    
    func refreshView() {
        guard let state = state, isViewLoaded else {
            return
        }
        
        refreshView(state)
    }
    
}

extension StoryboardBased where Self: NSViewController & Synchronous {
    
    static func instantiate(state: State) -> Self {
        let viewController = instantiate()
        viewController.state = state
        return viewController
    }
    
}
