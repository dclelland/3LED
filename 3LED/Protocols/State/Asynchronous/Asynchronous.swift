//
//  Asynchronous.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation
import PromiseKit

struct AsynchronousState<Input, Output> {
    
    enum Result<Output> {
        
        case ready
        case loading
        case success(Output)
        case failure(Error)
        
    }
    
    let input: Input
    
    let result: Result<Output>
    
}

protocol Asynchronous: Synchronous where State == AsynchronousState<Input, Output> {
    
    associatedtype Input
    
    associatedtype Output
    
    func requestState(_ state: State) -> Promise<Output>

}

extension Asynchronous where Self: NSViewController {
    
    func refreshState() {
        guard let state = state, isViewLoaded else {
            return
        }
        
        refreshState(state)
    }
    
    func refreshState(_ state: State) {
        self.state = AsynchronousState(input: state.input, result: .loading)
        
        requestState(state).done { [weak self] output in
            self?.state = AsynchronousState(input: state.input, result: .success(output))
        }.catch { [weak self] error in
            self?.state = AsynchronousState(input: state.input, result: .failure(error))
        }
    }
    
}

extension StoryboardBased where Self: NSViewController & Asynchronous {

    static func instantiate(input: Input) -> Self {
        let viewController = instantiate()
        viewController.state = AsynchronousState(input: input, result: .ready)
        return viewController
    }

}
