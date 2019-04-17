//
//  LightWaveformViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightWaveformViewController: StatefulViewController<LightState> {
    
    @IBOutlet var firstColorWell: NSColorWell!
    
    @IBOutlet var secondColorWell: NSColorWell!
    
    override func refreshView(_ state: LightState) {
        super.refreshView(state)
        
        firstColorWell.color = state.state.color.color
        secondColorWell.color = state.state.color.color
    }
    
}

extension LightWaveformViewController {
    
    @IBAction func setWaveform(_ sender: Any?) {
        guard let state = state else {
            return
        }
        
        state.light.setColor(color: firstColorWell.color).then { _ in
            state.light.setWaveform(color: self.secondColorWell.color, period: 0.25, waveform: .pulse)
        }.catch { error in
            NSAlert(error: error).runModal()
        }
    }
    
}
