//
//  StoryboardBased.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

protocol StoryboardBased: class {
    
    static var sceneStoryboard: NSStoryboard { get }
    
}

extension StoryboardBased {
    
    static var sceneStoryboard: NSStoryboard {
        return NSStoryboard(name: String(describing: self), bundle: Bundle(for: self))
    }
    
}

extension StoryboardBased where Self: NSWindowController {
    
    static func instantiate() -> Self {
        let windowController = sceneStoryboard.instantiateInitialController()
        guard let typedWindowController = windowController as? Self else {
            fatalError("The initialController of '\(sceneStoryboard)' is not of class '\(self)'")
        }
        return typedWindowController
    }
    
}

extension StoryboardBased where Self: NSViewController {
    
    static func instantiate() -> Self {
        let viewController = sceneStoryboard.instantiateInitialController()
        guard let typedViewController = viewController as? Self else {
            fatalError("The initialController of '\(sceneStoryboard)' is not of class '\(self)'")
        }
        return typedViewController
    }
    
}
