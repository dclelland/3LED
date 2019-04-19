//
//  LightColorWindowController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightColorWindowController: StatefulWindowController<Light>, StoryboardBased {
    
    override func refreshWindow(_ light: Light) {
        window?.title = "\(light.state.label) Color"
    }
    
}
