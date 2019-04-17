//
//  Light.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

struct Light {
    
    var name: String
    
    var host: String
    
    init() {
        self.name = ""
        self.host = ""
    }
    
    init(name: String = "", host: String = "") {
        self.name = name
        self.host = host
    }
    
}
