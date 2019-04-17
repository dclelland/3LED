//
//  LightWaveformWindowController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightWaveformWindowController: StatefulWindowController<LightState>, StoryboardBased {
    
    override func refreshWindow(_ state: LightState) {
        window?.title = state.state.label
    }
    
}
