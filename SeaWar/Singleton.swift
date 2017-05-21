//
//  Singleton.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import Foundation
import UIKit

class Singleton {
    static let gameInstance = Singleton()
    
    enum playerTurn {
        case player_one
        case player_two
    }
    
    var gameTurn = playerTurn.player_one
    
    // The board size, 10x10 of course
    let size = 10;
    
    // Define the colors for different grid states here
    let colorWater = UIColor(red: 20/255, green: 130/255, blue: 255/255, alpha: 1.0)
    let colorShip = UIColor.darkGray
    let colorSunk = UIColor(red: 255/255, green: 80/255, blue: 80/255, alpha: 1.0)
    
    // Boolean variable that marks the initialization of a game round
    // Initialization: Put all ships on the board first
    var isReady = false
    
    // Two player boards being maintained here
    var boardPlayerOne: GameBoard?
    var boardPlayerTwo: GameBoard?
    
    // Record how many times the ship grid has been hit
    var hitPlayerOne = 0
    var hitPlayerTwo = 0
}
