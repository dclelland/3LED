//
//  Promise+Extensions.swift
//  3LED
//
//  Created by Daniel Clelland on 21/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation
import PromiseKit

enum PMKTimeoutError: Swift.Error, LocalizedError {
    
    case timeout(seconds: TimeInterval)
    
    var errorDescription: String? {
        switch self {
        case .timeout(let seconds):
            return "Timeout after \(seconds) seconds"
        }
    }
    
}

extension Promise {
    
    func timeout(seconds: TimeInterval) -> Promise<T> {
        return race(
            self,
            after(seconds: seconds).map {
                throw PMKTimeoutError.timeout(seconds: seconds)
            }
        )
    }
    
}
