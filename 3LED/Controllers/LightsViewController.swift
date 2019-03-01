//
//  LightsViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 1/03/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import UIKit
import Reusable

protocol LightsViewControllerCoordinator: class {
    
}

class LightsViewController: UITableViewController, Coordinated, StoryboardBased {
    
    weak var coordinator: LightsViewControllerCoordinator?
    
}
