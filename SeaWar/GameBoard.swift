//
//  GameBoard.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import Foundation

class GameBoard {
    var map: Grid = Grid()
    
    // Ship length is 2 3 3 4 5
    var ship1: Ship = Ship(name: "Ship1", len: 2)
    var ship2: Ship = Ship(name: "Ship2", len: 3)
    var ship3: Ship = Ship(name: "Ship3", len: 3)
    var ship4: Ship = Ship(name: "Ship4", len: 4)
    var ship5: Ship = Ship(name: "Ship5", len: 5)
}
