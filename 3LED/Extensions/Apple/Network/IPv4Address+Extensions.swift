//
//  IPv4Address+Extensions.swift
//  3LED
//
//  Created by Daniel Clelland on 18/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation
import Network

extension IPv4Address {
    
    enum Error: Swift.Error, LocalizedError {
        
        case invalidString
        
        var errorDescription: String? {
            switch self {
            case .invalidString:
                return "Invalid IP address"
            }
        }
        
        var recoverySuggestion: String? {
            return "Please provide an IP address with a valid format, for example \"192.168.0.1\"."
        }
        
    }
    
    init(_ string: String) throws {
        guard let address = IPv4Address(string) else {
            throw Error.invalidString
        }
        
        self = address
    }
    
}
