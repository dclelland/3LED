//
//  Coordinator.swift
//  3LED
//
//  Created by Daniel Clelland on 1/03/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import UIKit

class Coordinator<ViewController: UIViewController>: NSObject {
    
    private(set) var viewController: ViewController
    
    private var children: [AnyObject] = []
    
    init(viewController: ViewController) {
        self.viewController = viewController
        super.init()
    }
    
}

extension Coordinator {
    
    func addChild<ViewController>(_ coordinator: Coordinator<ViewController>) {
        children.append(coordinator)
    }
    
    func removeChild<ViewController>(_ coordinator: Coordinator<ViewController>) {
        children.removeAll { child in
            return child === coordinator
        }
    }
    
    func removeAllChildren() {
        children = []
    }
    
}
