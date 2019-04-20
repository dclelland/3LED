//
//  LightColorWindowController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightColorWindowController: StatefulWindowController<Light>, StoryboardBased {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        if let window = window, let screen = window.screen {
            window.setFrameOrigin(
                NSPoint(
                    x: screen.desktopFrame.maxX - window.frame.width - 20.0,
                    y: screen.desktopFrame.maxY - window.frame.height - 20.0
                )
            )
        }
    }
    
    override func refreshWindow(_ light: Light) {
        window?.title = light.state.label
    }
    
}
