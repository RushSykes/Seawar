//
//  MarkBoardView.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import UIKit

// This is for the player who's taking the turn
// To fire missiles! (Or cannonballs...)
class MarkBoardView: UIView {
    var playerShips: GridView!
    var enemyShips: GridView!
    
    var playerGrid: GameBoard?
    var enemyGrid: GameBoard?
    
    init(frame: CGRect, playerGrid: GameBoard, enemyGrid: GameBoard) {
        super.init(frame: CGRect())
        
        self.playerGrid = playerGrid
        self.enemyGrid = enemyGrid
        
        playerShips = GridView(frame: CGRect(x: 10, y: (frame.width / 8) , width: frame.width - 20, height: frame.width - 20), board: playerGrid, touchable: false)
        enemyShips = GridView(frame: CGRect(x: 10, y: (frame.width / 8) , width: frame.width - 20, height: frame.width - 20), board: enemyGrid, touchable: true)
        
        addSubview(enemyShips)
        
        // For debug
        print("MarkBoardView initialized\n")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
