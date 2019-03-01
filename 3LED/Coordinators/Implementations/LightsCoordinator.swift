//
//  LightsCoordinator.swift
//  3LED
//
//  Created by Daniel Clelland on 1/03/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import UIKit
import LIFXClient
import Reusable

class LightsCoordinator: Coordinator<LightsNavigationController> {
    
    init() {
        super.init(viewController: LightsNavigationController.instantiate())
        self.viewController.viewControllers = [
            LightsViewController.instantiate(coordinator: self)
        ]
    }
    
}

//        LIFXClient.connect(host: .ipv4(IPv4Address("192.168.1.83")!)).then { client in
//            return client.light.setColor(color: .green)
//        }.done { response in
//            print(response)
//        }.catch { error in
//            print(error)
//        }

extension LightsCoordinator: LightsViewControllerCoordinator {
    
    func lightsViewController(_ lightsViewController: LightsViewController, didSelectLight light: LIFXLight) {
        let lightViewController = LightViewController.instantiate(coordinator: self)
        viewController.pushViewController(lightViewController, animated: true)
    }
    
}

extension LightsCoordinator: LightViewControllerCoordinator {
    
}
