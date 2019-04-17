//
//  Light.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

struct Light {
    
    var host: String
    
    var name: String
    
}

extension Light {
    
    static var all: [Light] {
        return [
            Light(
                host: "192.168.1.83",
                name: "Ceiling"
            ),
            Light(
                host: "192.168.1.84",
                name: "Anglepoise"
            )
        ]
    }
    
}
