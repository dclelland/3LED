//
//  LightWaveformWindowController.swift
//  3LED
//
//  Created by Daniel Clelland on 15/02/20.
//  Copyright © 2020 Protonome. All rights reserved.
//

import AppKit

class LightWaveformWindowController: StatefulWindowController<Light>, StoryboardBased {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        shouldCascadeWindows = true
    }
    
    override func refreshWindow(_ light: Light) {
        super.refreshWindow(light)
        
        windowFrameAutosaveName = "\(light.state.label) Waveform"
        window?.title = "\(light.state.label) Waveform"
    }
    
}
