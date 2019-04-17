//
//  Bundle+Extensions.swift
//  3LED
//
//  Created by Daniel Clelland on 17/04/19.
//  Copyright © 2019 Protonome. All rights reserved.
//

import Foundation

extension Bundle {
    
    var name: String {
        return object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
}
