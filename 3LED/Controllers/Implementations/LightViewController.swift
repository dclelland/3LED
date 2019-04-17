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

    override func request(_ light: Light) -> Promise<LIFXLight> {
        return LIFXClient.connect(host: .ipv4(IPv4Address(light.host)!)).map { client in
            return client.light
        }
    }
    
    override func refreshView(_ state: AsynchronousState<LIFXLight>) {
        super.refreshView(state)
        
        switch state {
        case .ready:
            title = "Ready"
        case .loading:
            title = "Loading"
        case .success:
            title = "Success"
        case .failure:
            title = "Failure"
        }
    }
    
}
