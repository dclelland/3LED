//
//  Sequence+Extensions.swift
//  3LED
//
//  Created by Daniel Clelland on 19/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

extension Sequence {
    
    func firstCast<T>(where predicate: (T) throws -> Bool) rethrows -> T? {
        return try compactCast(to: T.self).first(where: predicate)
    }
    
    func compactCast<T>(to type: T.Type) -> [T] {
        return compactMap { element in
            return element as? T
        }
    }
    
}
