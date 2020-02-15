//
//  LightWaveformViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 15/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit
import PromiseKit

class LightWaveformViewController: StatefulViewController<Light> {
    
    @IBOutlet var firstColorWell: NSColorWell!
    
    @IBOutlet var secondColorWell: NSColorWell!
    
    @IBOutlet var periodSlider: NSSlider!
    
    override func refreshView(_ light: Light) {
        super.refreshView(light)
        
        firstColorWell.color = light.state.color.color
        secondColorWell.color = light.state.color.color
        periodSlider.doubleValue = 1.0
    }
    
}

extension LightWaveformViewController {
    
    @IBAction func setWaveform(_ sender: Any?) {
        guard let light = state?.client.light else {
            return
        }
        
        when(fulfilled: light.setColor(color: firstColorWell.color), after(seconds: 0.1)).then { state in
            light.setWaveform(color: self.secondColorWell.color, period: 1.0 / self.periodSlider.doubleValue, waveform: .pulse)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}
