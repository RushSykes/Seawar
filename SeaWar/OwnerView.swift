//
//  OwnerBoardView.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import UIKit

// This is before the marking phase
// Two players could have a chance to appraise their own ship postions
// The only difference is that player could not touch grid
// So touchable is set to false

class OwnerBoardView: UIView {
    
    var playerShips: GridView!
    var board: GameBoard?
    
    init(frame: CGRect, currentBoard: GameBoard) {
        // super.init(frame: frame)
        super.init(frame: CGRect())
        
        // Player needs to put his ships on the board
        board = currentBoard
        
        playerShips = GridView(frame: CGRect(x: 10, y: (frame.width / 8) , width: frame.width - 20, height: frame.width - 20), board: currentBoard, touchable: false)
        
        addSubview(playerShips)
        
        // For debug
        print("OwnerBoardView initialized\n")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
