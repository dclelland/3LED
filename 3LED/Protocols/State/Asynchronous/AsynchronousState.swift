//
//  AsynchronousState.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

enum AsynchronousState<Output> {
    
    case ready
    case loading
    case success(Output)
    case failure(Error)
    
    init() {
        self = .ready
    }
    
}

extension AsynchronousState {
    
    var output: Output? {
        get {
            guard case .success(let output) = self else {
                return nil
            }
            
            return output
        }
        set {
            guard let output = newValue else {
                return
            }
            
            self = .success(output)
        }
    }
    
    var error: Error? {
        get {
            guard case .failure(let error) = self else {
                return nil
            }
            
            return error
        }
        set {
            guard let error = newValue else {
                return
            }
            
            self = .failure(error)
        }
    }
    
}
