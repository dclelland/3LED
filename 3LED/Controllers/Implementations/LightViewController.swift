//
//  LightViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit
import Network
import LIFXClient
import PromiseKit

class LightViewController: AsynchronousViewController<Light, LIFXLight>, StoryboardBased {
    
    override func requestState(_ state: AsynchronousState<Light, LIFXLight>) -> Promise<LIFXLight> {
        return LIFXClient.connect(host: .ipv4(IPv4Address(state.input.host)!)).map { client in
            return client.light
        }
    }
    
    override func refreshView(_ state: AsynchronousState<Light, LIFXLight>) {
        super.refreshView(state)
        
        switch state.result {
        case .ready:
            title = state.input.name
        case .loading:
            title = state.input.name
        case .success(let light):
            title = "Success"
        case .failure:
            title = "Failure"
        }
    }
    
}
