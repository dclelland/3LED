//
//  LightViewController.swift
//  3LED
//
//  Created by Daniel Clelland on 1/03/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import UIKit
import Reusable

protocol LightViewControllerCoordinator: class {
    
}

class LightViewController: UITableViewController, Coordinated, StoryboardBased {

    weak var coordinator: LightViewControllerCoordinator?
    
}
