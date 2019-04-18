//
//  LightWaveformViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightWaveformViewController: StatefulViewController<Light> {
    
    @IBOutlet var firstColorWell: NSColorWell!
    
    @IBOutlet var secondColorWell: NSColorWell!
    
    override func refreshView(_ light: Light) {
        super.refreshView(light)
        
        firstColorWell.color = light.state.color.color
        secondColorWell.color = light.state.color.color
    }
    
}

extension LightWaveformViewController {
    
    @IBAction func setWaveform(_ sender: Any?) {
        guard let light = state else {
            return
        }
        
        light.client.light.setColor(color: firstColorWell.color).then { _ in
            light.client.light.setWaveform(color: self.secondColorWell.color, period: 0.25, waveform: .pulse)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}
