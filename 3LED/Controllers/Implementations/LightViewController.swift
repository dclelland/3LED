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

struct LightViewControllerState {
    
    var light: LIFXLight
    
    var lightState: LIFXLight.State
    
}

class LightViewController: SynchronousViewController<LightViewControllerState>, StoryboardBased {
    
    @IBOutlet var colorWell: NSColorWell!
    
    override func refreshView(_ state: LightViewControllerState) {
        super.refreshView(state)
        
        title = state.lightState.label
        colorWell.color = state.lightState.color.color
    }
    
}

extension LightViewController {
    
    @IBAction func colorWellValueDidChange(_ sender: NSColorWell) {
        state?.light.setColor(color: sender.color).catch { error in
            print(error)
        }
    }
    
}
