//
//  LightColorViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightColorViewController: StatefulViewController<LightState> {
    
    @IBOutlet var colorWell: NSColorWell!
    
    override func refreshView(_ state: LightState) {
        super.refreshView(state)
        
        colorWell.color = state.state.color.color
    }
    
}

extension LightColorViewController {
    
    @IBAction func setColor(_ sender: Any?) {
        guard let state = state else {
            return
        }
        
        state.light.setColor(color: colorWell.color).catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}
