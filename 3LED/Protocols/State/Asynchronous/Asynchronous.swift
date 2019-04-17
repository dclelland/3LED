//
//  Asynchronous.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation
import PromiseKit

protocol Asynchronous: Synchronous where State == AsynchronousState<Input, Output> {
    
    associatedtype Input
    
    associatedtype Output
    
    func request(input: Input) -> Promise<Output>

}

extension Asynchronous {
    
    func refresh() {
        guard let state = state else {
            return
        }
        
        defer {
            self.state?.result = .loading
        }
        
        request(input: state.input).done { [weak self] output in
            self?.state?.result = .success(output)
        }.catch { [weak self] error in
            self?.state?.result = .failure(error)
        }
    }
    
}

extension StoryboardBased where Self: NSViewController & Asynchronous {

    static func instantiate(input: Input) -> Self {
        return instantiate(state: AsynchronousState<Input, Output>(input: input))
    }

}
