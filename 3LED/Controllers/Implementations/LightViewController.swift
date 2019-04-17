//
//  LightViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import AppKit

class LightViewController: SynchronousViewController<Light>, StoryboardBased {

    override func refreshView(_ light: Light) {
        title = light.name
    }
    
}
