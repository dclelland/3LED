//
//  LightColorViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightColorViewController: StatefulViewController<LightState>, StoryboardBased {
    
    @IBOutlet var colorWell: NSColorWell!
    
    override func refreshView(_ state: LightState) {
        super.refreshView(state)
        
        title = "\(state.state.label) Color"
        colorWell.color = state.state.color.color
    }
    
}

extension LightColorViewController {
    
    @IBAction func colorWellValueDidChange(_ sender: NSColorWell) {
        state?.light.setColor(color: sender.color).catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}
