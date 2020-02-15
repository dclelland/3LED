//
//  LightWaveformViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 15/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit

class LightWaveformViewController: StatefulViewController<Light> {
    
    @IBOutlet var firstColorWell: NSColorWell!
    
    @IBOutlet var secondColorWell: NSColorWell!
    
    override func refreshView(_ light: Light) {
        super.refreshView(light)
        
        firstColorWell.color = light.state.color.color
        secondColorWell.color = .black
    }
    
}

extension LightWaveformViewController {
    
    @IBAction func setWaveform(_ sender: Any?) {
        guard let light = state?.client.light else {
            return
        }
        
        light.setColor(color: firstColorWell.color).then { state in
            light.setWaveform(transient: true, color: self.secondColorWell.color, period: 0.5, waveform: .pulse)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}
