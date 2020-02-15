//
//  LightWaveformViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 15/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit
import LIFXClient
import PromiseKit

class LightWaveformViewController: StatefulViewController<Light> {
    
    @IBOutlet var firstColorWell: NSColorWell!
    
    @IBOutlet var secondColorWell: NSColorWell!
    
    @IBOutlet var periodSlider: NSSlider!
    
    @IBOutlet var waveformPopUpButton: NSPopUpButton!
    
    override func refreshView(_ light: Light) {
        super.refreshView(light)
        
        firstColorWell.color = light.state.color.color
        secondColorWell.color = light.state.color.color
        periodSlider.doubleValue = 0.0
        waveformPopUpButton.selectItem(withTag: Int(LIFXLight.Waveform.sine.rawValue))
    }
    
}

extension LightWaveformViewController {
    
    @IBAction func setWaveform(_ sender: Any?) {
        guard let light = state?.client.light else {
            return
        }
        
        let firstColor = firstColorWell.color
        let secondColor = secondColorWell.color
        let period = pow(30.0, -self.periodSlider.doubleValue)
        let waveform = LIFXLight.Waveform(rawValue: UInt8(waveformPopUpButton.selectedTag()))!
        
        light.setColor(color: secondColor).then { state in
            light.setWaveform(color: firstColor, period: period, waveform: waveform)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}
