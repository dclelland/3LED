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

struct LightViewControllerOutput {
    
    var light: LIFXLight
    
    var lightState: LIFXLight.State
    
}

class LightViewController: AsynchronousViewController<Light, LightViewControllerOutput>, StoryboardBased {
    
    @IBOutlet var colorWell: NSColorWell!
    
    override func requestState(_ state: AsynchronousState<Light, LightViewControllerOutput>) -> Promise<LightViewControllerOutput> {
        return LIFXClient.connect(host: .ipv4(IPv4Address(state.input.host)!)).then { client in
            return client.light.get().map { lightState -> LightViewControllerOutput in
                return LightViewControllerOutput(light: client.light, lightState: lightState)
            }
        }
    }
    
    override func refreshView(_ state: AsynchronousState<Light, LightViewControllerOutput>) {
        super.refreshView(state)
        
        switch state.result {
        case .ready:
            title = state.input.name
        case .loading:
            title = state.input.name
        case .success(let output):
            title = output.lightState.label
            colorWell.color = output.lightState.color.color
        case .failure:
            title = state.input.name
        }
    }
    
}

extension LightViewController {
    
    @IBAction func colorWellValueDidChange(_ sender: NSColorWell) {
        guard let light = state?.result.output else {
            return
        }
        
        light.light.setColor(color: sender.color).catch { error in
            print(error)
        }
    }
    
}
