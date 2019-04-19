//
//  Stateful.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

protocol Stateful: class {
    
    associatedtype State
    
    var state: State? { get set }
    
}

extension StoryboardBased where Self: NSWindowController & Stateful {
    
    static func instantiate(state: State) -> Self {
        let windowController = instantiate()
        windowController.state = state
        return windowController
    }
    
}

extension StoryboardBased where Self: NSWindowController & Stateful, Self.State: Equatable {
    
    static func first(state: State) -> Self? {
        return first { windowController in
            return windowController.state == state
        }
    }
    
    static func firstOrInstantiate(state: State) -> Self {
        return first(state: state) ?? instantiate(state: state)
    }
    
}
