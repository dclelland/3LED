//
//  LightsViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 1/03/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import UIKit
import LIFXClient
import Reusable

protocol LightsViewControllerCoordinator: class {
    
    func lightsViewController(_ lightsViewController: LightsViewController, didSelectLight light: LIFXLight)
    
}

class LightsViewController: UITableViewController, Coordinated, StoryboardBased {
    
    weak var coordinator: LightsViewControllerCoordinator?
    
}
