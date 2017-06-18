//
//  InitBoardView.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import UIKit

// This is for the preparation phase
// Two players need to set the position of their ships

class InitBoardView: UIView {
    
    var playerShips: GridView!
    var board: GameBoard?
    
    init(frame: CGRect, currentBoard: GameBoard) {
        // super.init(frame: frame)
        super.init(frame: CGRect())
        
        // Player needs to put his ships on the board
        board = currentBoard
        
        playerShips = GridView(frame: CGRect(x: 10, y: (frame.width / 8) , width: frame.width - 20, height: frame.width - 20), board: currentBoard, touchable: true)
        
        addSubview(playerShips)
        
        // For debug
        print("InitBoardView initialized\n")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
