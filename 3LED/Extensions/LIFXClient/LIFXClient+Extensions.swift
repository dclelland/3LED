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

extension LIFXClient {
    
    static func getLightStates(addresses: [String]) -> Guarantee<[Result<LightState>]> {
        return when(
            resolved: addresses.map { address in
                return connect(address: address).then { client in
                    return client.light.getState()
                }
            }
        )
    }
    
}

extension LIFXClient {
    
    static func connect(address: String) -> Promise<LIFXClient> {
        #warning("Validate ipv4 here")
        return connect(host: .ipv4(IPv4Address(address)!))
    }
    
}

extension LIFXLight {
    
    func getState() -> Promise<LightState> {
        return get().map { state -> LightState in
            return LightState(light: self, state: state)
        }
    }
    
}

struct LightState {
    
    var light: LIFXLight
    
    var state: LIFXLight.State
    
}
