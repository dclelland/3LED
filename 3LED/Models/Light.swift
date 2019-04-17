//
//  Light.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

struct Light {
    
    var address: String
    
    var name: String
    
    var powered: Bool
    
}

extension Light {
    
    static var all: [Light] {
        return [
            Light(
                address: "192.168.1.83",
                name: "Ceiling",
                powered: true
            ),
            Light(
                address: "192.168.1.84",
                name: "Anglepoise",
                powered: false
            )
        ]
    }
    
}
