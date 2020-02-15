//
//  LightColorViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightColorViewController: StatefulViewController<Light> {
    
    @IBOutlet var colorWell: NSColorWell!
    
    override func refreshView(_ light: Light) {
        super.refreshView(light)
        
        colorWell.color = light.state.color.color
    }
    
}

extension LightColorViewController {
    
    @IBAction func setColor(_ sender: Any?) {
        guard let light = state?.client.light else {
            return
        }
        
        light.setColor(color: colorWell.color).catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}
