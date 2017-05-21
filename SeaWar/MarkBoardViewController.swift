//
//  MarkBoardViewController.swift
//  SeaWar
//
//  Created by Rush Sykes on 21/05/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import UIKit

class MarkBoardViewController: UIViewController, UIAlertViewDelegate {
    
    var launchButton: UIButton?
    var nextButton: UIButton?
    var p1_BoardView: MarkBoardView?
    var p2_BoardView: MarkBoardView?
    let board1 = Singleton.gameInstance.boardPlayerOne!
    let board2 = Singleton.gameInstance.boardPlayerTwo!
    var p1_LastFireLocation: (row: Int, col: Int) = (-1, -1)
    var p2_LastFireLocation: (row: Int, col: Int) = (-1, -1)
    var popUpMessage: UIAlertView = UIAlertView()
    var currentPlayerHit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popUpMessage.addButton(withTitle: "OK")
        p1_BoardView = MarkBoardView(frame: view.bounds, playerGrid: board1, enemyGrid: board2)
        p2_BoardView = MarkBoardView(frame: view.bounds, playerGrid: board2, enemyGrid: board1)
        
        if (Singleton.gameInstance.gameTurn == .player_one) {
            view = p1_BoardView
        } else {
            view = p2_BoardView
        }
        view.backgroundColor = UIColor.init(red: 50/255 , green: 150/255 , blue: 1.0, alpha: 1.0)
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: screenWidth * 2 / 4, y: 30)
        label.textAlignment = NSTextAlignment.center
        label.text = "Select a target to attack!"
        self.view.addSubview(label)
        
        let playerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
        playerLabel.center = CGPoint(x: screenWidth / 2, y: screenHeight * 10 / 16)
        playerLabel.textAlignment = NSTextAlignment.center
        if (Singleton.gameInstance.gameTurn == .player_one) {
            playerLabel.text = "Player 1"
        } else {
            playerLabel.text = "Player 2"
        }
        self.view.addSubview(playerLabel)
        
        launchButton = UIButton(frame: CGRect(x: screenWidth * 2 / 4, y: screenHeight * 14 / 16, width: 120, height: 40))
        launchButton!.backgroundColor = .gray
        launchButton!.setTitle("Attack This", for: UIControlState())
        launchButton!.addTarget(self, action: #selector(launchAction), for: .touchUpInside)
        self.view.addSubview(launchButton!)
        
        nextButton = UIButton(frame: CGRect(x: screenWidth * 2 / 4, y: screenHeight * 14 / 16, width: 120, height: 40))
        nextButton!.backgroundColor = .gray
        nextButton!.setTitle("Finished", for: UIControlState())
        nextButton!.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    func launchAction(_ sender: UIButton!) {
        if (Singleton.gameInstance.gameTurn == .player_one) {
            if (!p1_FiredMissle()) {
                return
            }
            if currentPlayerHit == false{
                Singleton.gameInstance.gameTurn = .player_two
            }
        }
        else {
            if (!p2_FiredMissle()) {
                return
            }
            if currentPlayerHit == false{
                Singleton.gameInstance.gameTurn = .player_one
            }
        }
        
        self.p1_BoardView?.setNeedsDisplay()
        self.p2_BoardView?.setNeedsDisplay()
        if currentPlayerHit == false{
            launchButton!.removeFromSuperview()
            self.view.addSubview(nextButton!)
        }
    }
    
    func nextAction(_ sender: UIButton!) {
        performSegue(withIdentifier: "toTransit", sender: nil)
    }
    
    func updateAll() {
        p1_BoardView!.playerShips.updateGridStatus()
        Singleton.gameInstance.boardPlayerOne = p1_BoardView!.playerShips.board
        p2_BoardView!.playerShips.updateGridStatus()
        Singleton.gameInstance.boardPlayerTwo = p2_BoardView!.playerShips.board
    }
    
    func p1_FiredMissle() -> Bool{
        // If player does not select one return false right away
        if(p1_BoardView!.enemyShips.selectedCoord == nil) {
            notSelectedMsg()
            return false
        }
        
        // Make sure not select the previous button
        let location = p1_BoardView!.enemyShips.buttonTouched
        let row: Int = location.row
        let column: Int = location.col
        
        if(row == p1_LastFireLocation.row && column == p1_LastFireLocation.col) {
            return false
        }
        else{
            p1_LastFireLocation = (row, column)
        }
        
        // Get location Status from Player2
        let locationStatus = Singleton.gameInstance.boardPlayerTwo!.map.getStatusFromCoord(col: column, row: row)
        
        if locationStatus == .isWater {
            // Update both views for a miss
            self.p1_BoardView!.enemyShips.buttonTouched((row: row, col: column), with: .isMissed)
            self.p2_BoardView!.playerShips.buttonTouched((row: row, col: column), with: .isMissed)
            currentPlayerHit = false
            updateAll()
            missedMsg()
            
        } else if locationStatus == .isShip {
            // Update both views for a hit
            self.p1_BoardView!.enemyShips.buttonTouched((row: row, col: column), with: .isHit)
            self.p2_BoardView!.playerShips.buttonTouched((row: row, col: column), with: .isSunk)
            currentPlayerHit = true
            Singleton.gameInstance.hitPlayerOne = Singleton.gameInstance.hitPlayerOne + 1
            updateAll()
            
            // Check player if win or not
            let totalShipSize = 2 + 3 + 3 + 4 + 5
            if(Singleton.gameInstance.hitPlayerOne == totalShipSize){
                wonMsg()
                resetGame()
                performSegue(withIdentifier: "toWin", sender: nil)
            } else{
                hitMsg()
            }
        } else {
            print("There is am invalid state in the board!")
        }
        return true
    }
    
    func p2_FiredMissle() -> Bool{
        // If player does not select one return false right away
        if(p2_BoardView!.enemyShips.selectedCoord == nil) {
            notSelectedMsg()
            return false
        }
        
        // Make sure not select the previous button
        let location = p2_BoardView!.enemyShips.buttonTouched
        let row: Int = location.row
        let column: Int = location.col
        
        if(row == p2_LastFireLocation.row && column == p2_LastFireLocation.col) {
            return false
        }
        else{
            p2_LastFireLocation = (row, column)
        }
        
        // Get location Status from Player1
        let locationStatus = Singleton.gameInstance.boardPlayerOne!.map.getStatusFromCoord(col: column, row: row)
        
        if locationStatus == .isWater {
            // Update both views for a miss
            self.p2_BoardView!.enemyShips.buttonTouched((row: row, col: column), with: .isMissed)
            self.p1_BoardView!.playerShips.buttonTouched((row: row, col: column), with: .isMissed)
            currentPlayerHit = false
            updateAll()
            missedMsg()
            
        } else if locationStatus == .isShip {
            // Update both views for a hit
            self.p2_BoardView!.enemyShips.buttonTouched((row: row, col: column), with: .isHit)
            self.p1_BoardView!.playerShips.buttonTouched((row: row, col: column), with: .isSunk)
            currentPlayerHit = true
            Singleton.gameInstance.hitPlayerTwo = Singleton.gameInstance.hitPlayerTwo + 1
            updateAll()
            
            // Check player if win or not
            let totalShipSize = 2 + 3 + 3 + 4 + 5
            if(Singleton.gameInstance.hitPlayerTwo == totalShipSize){
                wonMsg()
                resetGame()
                performSegue(withIdentifier: "toWin", sender: nil)
            } else{
                hitMsg()
            }
        } else {
            print("There is am invalid state in the board!")
        }
        return true
    }
    
    func resetGame() {
        Singleton.gameInstance.gameTurn = .player_one
        Singleton.gameInstance.hitPlayerOne = 0
        Singleton.gameInstance.hitPlayerTwo = 0
        Singleton.gameInstance.isReady = false
        
        p1_BoardView!.playerShips.resetStatus()
        Singleton.gameInstance.boardPlayerOne = p1_BoardView!.playerShips.board
        p2_BoardView!.playerShips.resetStatus()
        Singleton.gameInstance.boardPlayerTwo = p2_BoardView!.playerShips.board
    }
    
    func wonMsg() {
        popUpMessage.title = "You sunk all opponent's ships, You won!"
        popUpMessage.show()
    }
    
    func hitMsg() {
        popUpMessage.title = "BOOM! You hit opponent's ship!"
        popUpMessage.show()
    }
    
    func missedMsg() {
        popUpMessage.title = "Sorry you missed it!"
        popUpMessage.show()
    }
    
    func notSelectedMsg() {
        popUpMessage.title = "OOPS! Please select a location to attack."
        popUpMessage.show()
    }
    
}
