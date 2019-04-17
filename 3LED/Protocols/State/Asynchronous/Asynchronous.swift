//
//  Asynchronous.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation
import PromiseKit

enum AsynchronousState<Output> {
    
    case ready
    case loading
    case success(Output)
    case failure(Error)
    
}

protocol Asynchronous: Synchronous where State == AsynchronousState<Output> {
    
    associatedtype Input
    
    associatedtype Output
    
    var input: Input? { get set }
    
    func requestState(_ input: Input) -> Promise<Output>

}

extension Asynchronous where Self: NSViewController {
    
    func refreshState() {
        guard let input = input, isViewLoaded else {
            return
        }
        
        refreshState(input)
    }
    
    func refreshState(_ input: Input) {
        self.state = .loading
        
        requestState(input).done { [weak self] output in
            self?.state = .success(output)
        }.catch { [weak self] error in
            self?.state = .failure(error)
        }
    }
    
}

extension StoryboardBased where Self: NSViewController & Asynchronous {

    static func instantiate(input: Input) -> Self {
        let viewController = instantiate()
        viewController.input = input
        return viewController
    }

}
