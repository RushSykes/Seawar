//
//  GridView.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import UIKit

// This is for all the grids in the 10x10 board
// They are in fact buttons

class GridView: UIView, GridButtonDelegete {
    
    // Board grid info
    let maxWidth = (UInt32)(Singleton.gameInstance.size)
    let maxHeight = (UInt32)(Singleton.gameInstance.size)
    
    // Ship length is 2 3 3 4 5
    var ship1: Ship = Ship(name: "Ship1", len: 2)
    var ship2: Ship = Ship(name: "Ship2", len: 3)
    var ship3: Ship = Ship(name: "Ship3", len: 3)
    var ship4: Ship = Ship(name: "Ship4", len: 4)
    var ship5: Ship = Ship(name: "Ship5", len: 5)
    
    // Variable max width and height
    var maxW = Singleton.gameInstance.size
    var maxH = Singleton.gameInstance.size
    
    var map: (width: Int, height: Int) = (Singleton.gameInstance.size, Singleton.gameInstance.size)
    var isVisitable = true
    
    // Record the info of each move
    var selectedCoord: (row: Int, col: Int)?
    var lastCoord: (row: Int, col: Int)?
    var board: GameBoard?
    
    init(frame: CGRect, board: GameBoard, touchable: Bool) {
        super.init(frame: frame)
        self.board = board
        isVisitable = touchable
        addGridButtons(board: board, touchable: touchable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Add gridbutton, with status
    private func addGridButtons(board: GameBoard, touchable: Bool) {
        isUserInteractionEnabled = touchable
        
        for rowIndex in 0..<maxH {
            for colIndex in 0..<maxW {
                let buttonFrame = CGRect(x: CGFloat(rowIndex) * (bounds.size.width / CGFloat(maxH)),
                                         y: CGFloat(colIndex) * (bounds.size.height / CGFloat(maxW)),
                                         width: bounds.size.width / CGFloat(maxH),
                                         height: bounds.size.height / CGFloat(maxH))
                let grid = GridButton(frame: buttonFrame, delegate: self)
                let status = board.map.getStatusFromCoord(col: colIndex, row: rowIndex)
                
                // If the button is touchable (not visited before) and it's not a ship
                if((touchable && status != .isShip) || !touchable) {
                    grid.buttonCurrentStatus = status
                }
                grid.x  = rowIndex
                grid.y = colIndex
                addSubview(grid)
            } // maxW for
        } // maxH for
        print("All gridButtons added\n")
    } // addGridButton
    
    // Implement the protocol
    func updateButton(row: Int, col: Int) {
        buttonTouched = (row, col)
    }
    
    // The current button that has just been touched
    var buttonTouched: (row: Int, col: Int) {
        get{
            return selectedCoord!
        }
        set{
            selectedCoord = newValue
            
            if Singleton.gameInstance.isReady == true {
                if !previousButtonIsVisited() {
                    if lastCoord != nil {
                        buttonTouched(lastCoord!, with: .isWater)
                    }
                    lastCoord = newValue
                }
                buttonTouched(newValue, with: .isSelected)
            }
            else {
                if checkButtonStatus(selectedCoord!) == .isShip {
                    if(lastCoord != nil){
                        buttonTouched(selectedCoord!, with: .isWater)
                    }
                    lastCoord = newValue
                }
                else if checkButtonStatus(selectedCoord!) == .isWater {
                    buttonTouched(newValue, with: .isShip)
                }
            }
        }
    } // var buttonTouched
    
    // Button updated with specific status
    func buttonTouched(_ location: (row: Int, col: Int), with status: GridStatus) {
        (subviews[location.row * maxW + location.col] as! GridButton).buttonCurrentStatus = status
    }
    
    // Check button status
    func checkButtonStatus(_ location: (row: Int, col: Int)) -> GridStatus {
        return (subviews[location.row * maxW + location.col] as! GridButton).buttonCurrentStatus
    }
    
    // Save player's ships
    func updateGridStatus() {
        for grid in subviews {
            board!.map.setStatusToCoord(col: (grid as! GridButton).y,
                                        row: (grid as! GridButton).x,
                                        status: (grid as! GridButton).buttonCurrentStatus)
        }
    }
    
    // Verify ships in the map == total size 17
    func verifyShips() -> Bool {
        var total = 0
        for grid in subviews {
            if ((grid as! GridButton).buttonCurrentStatus == .isShip) {
                total = total + 1
            }
        }
        if (total == 17) {
            return true
        }
        else {
            return false
        }
    }
    
    // Reset status
    func resetStatus() {
        for grid in subviews {
            (grid as! GridButton).buttonCurrentStatus = .isWater
        }
    }
    
    // No duplicate selection
    func previousButtonIsVisited() -> Bool{
        if(lastCoord == nil){
            return false
        }
        return (selectedCoord!.row == lastCoord!.row && selectedCoord!.col == lastCoord!.col)
    }
    
    // Randomly put 5 ships on the board
    // Orientations varies for each ship according to a random value
    func randomize() {
        randomPlacedInMap(ship1)
        randomPlacedInMap(ship2)
        randomPlacedInMap(ship3)
        randomPlacedInMap(ship4)
        randomPlacedInMap(ship5)
    }
    
    fileprivate func randomPlacedInMap(_ ship: Ship) {
        let orientation: Int = (Int)(arc4random_uniform(2))
        var shipPlaced = false
        
        if(orientation == 0) {
            while(!shipPlaced){
                shipPlaced = randomPlaceShipHorizontally(ship.len)
            }
        } else {
            while(!shipPlaced){
                shipPlaced = randomPlaceShipVertically(ship.len)
            }
        }
    }
    
    func randomPlaceShipHorizontally(_ spaceSize: Int) -> Bool {
        
        var columnIndex: Int = (Int)(arc4random_uniform(maxWidth))
        var rowIndex: Int = (Int)(arc4random_uniform(maxHeight))
        
        while (columnIndex + spaceSize > 9) {
            columnIndex = (Int)(arc4random_uniform(maxWidth))
            rowIndex = (Int)(arc4random_uniform(maxHeight))
        }
        
        for index in 0..<spaceSize {
            if(checkButtonStatus((rowIndex, col: columnIndex + index)) == .isShip) {
                return false
            }
        }
        
        for index in 0..<spaceSize {
            print("\(rowIndex),\(columnIndex + index)\n")
            buttonTouched((row: rowIndex, col: columnIndex + index), with: .isShip)
        }
        return true
    }
    
    func randomPlaceShipVertically(_ spaceSize: Int) -> Bool {
        
        var columnIndex: Int = (Int)(arc4random_uniform(maxWidth))
        var rowIndex: Int = (Int)(arc4random_uniform(maxHeight))
        
        while (rowIndex + spaceSize >= Singleton.gameInstance.size) {
            columnIndex = (Int)(arc4random_uniform(maxWidth))
            rowIndex = (Int)(arc4random_uniform(maxHeight))
        }
        
        for index in 0..<spaceSize {
            if(checkButtonStatus((rowIndex + index, col: columnIndex)) == .isShip) {
                return false
            }
        }
        
        for index in 0..<spaceSize{
            print("\(rowIndex + index),\(columnIndex)\n")
            buttonTouched((row: rowIndex + index, col: columnIndex), with: .isShip)
        }
        return true
    }
}
