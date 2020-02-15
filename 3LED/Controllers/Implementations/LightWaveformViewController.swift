//
//  LightWaveformViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 15/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit

class LightWaveformViewController: StatefulViewController<Light> {
    
    @IBOutlet var colorWell: NSColorWell!
    
    override func refreshView(_ light: Light) {
        super.refreshView(light)
        
        colorWell.color = light.state.color.color
    }
    
}

extension LightWaveformViewController {
    
    @IBAction func setColor(_ sender: Any?) {
        guard let light = state else {
            return
        }
        
        light.client.light.setColor(color: colorWell.color).catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}
