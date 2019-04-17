//
//  LightWaveformViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightWaveformViewController: StatefulViewController<LightState>, StoryboardBased {
    
    override func refreshView(_ state: LightState) {
        super.refreshView(state)
        
        title = "\(state.state.label) Waveform"
    }
    
}
