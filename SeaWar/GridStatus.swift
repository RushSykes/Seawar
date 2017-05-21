//
//  GridStatus.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

// Grid Status needed for game mechanics
// There are six states that a grid cound be in
enum GridStatus: Int {
    case isWater
    case isShip
    case isHit
    case isMissed
    case isSunk
    case isSelected
}
