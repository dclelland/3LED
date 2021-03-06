//
//  LightWindowController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightWindowController: StatefulWindowController<Light>, StoryboardBased {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        shouldCascadeWindows = true
    }
    
    override func refreshWindow(_ light: Light) {
        super.refreshWindow(light)
        
        windowFrameAutosaveName = light.state.label
        window?.title = light.state.label
    }
    
}
