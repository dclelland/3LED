//
//  Coordinated.swift
//  3LED
//
//  Created by Daniel Clelland on 1/03/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import UIKit
import Reusable

protocol Coordinated: class {
    
    associatedtype Coordinator
    
    var coordinator: Coordinator? { get set }
    
}

extension StoryboardBased where Self: UIViewController, Self: Coordinated {
    
    static func instantiate(coordinator: Coordinator) -> Self {
        let viewController = instantiate()
        viewController.coordinator = coordinator
        return viewController
    }
    
}
