//
//  Ship.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import Foundation

class Ship {
    var name: String = ""
    var len: Int = 0;
    
    // Set a ship's attributes
    init(name: String, len: Int) {
        self.name = name
        self.len = len
    }
}
