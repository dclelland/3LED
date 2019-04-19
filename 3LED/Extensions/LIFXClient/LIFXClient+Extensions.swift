//
//  LIFXClient+Extensions.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation
import Network
import LIFXClient
import PromiseKit

enum Connection {
    
    case connected(address: String, light: Light)
    case disconnected(address: String, error: Error)
    
}

struct Light: Equatable {
    
    var client: LIFXClient
    var state: LIFXLight.State
    
    static func == (lhs: Light, rhs: Light) -> Bool {
        return lhs.client.connection.endpoint == rhs.client.connection.endpoint
    }
    
}

extension LIFXClient {
    
    static func getConnections(addresses: [String]) -> Guarantee<[Connection]> {
        let promises = addresses.map { address in
            return connect(address: address).then { client in
                return client.light.get().map { state in
                    return Light(client: client, state: state)
                }
            }
        }
        
        return when(resolved: promises).map { results in
            return zip(addresses, results).map { address, result in
                switch result {
                case .fulfilled(let light):
                    return .connected(address: address, light: light)
                case .rejected(let error):
                    return .disconnected(address: address, error: error)
                }
            }
        }
    }
    
}

extension LIFXClient {
    
    #warning("Need to add timeout here")
    
    static func connect(address: String) -> Promise<LIFXClient> {
        return firstly {
            return connect(host: .ipv4(try IPv4Address(address)))
        }
    }
    
}
