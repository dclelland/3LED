//
//  Asynchronous.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation
import PromiseKit

protocol Asynchronous: Synchronous where State == AsynchronousState<Output> {
    
    associatedtype Input
    
    associatedtype Output
    
    var input: Input? { get set }
    
    func request(_ input: Input) -> Promise<Output>

}

extension StoryboardBased where Self: NSViewController & Asynchronous {

    static func instantiate(input: Input) -> Self {
        let viewController = instantiate()
        viewController.input = input
        return viewController
    }

}
