//
//  OwnerBoardViewController.swift
//  SeaWar
//
//  Created by Rush Sykes on 21/05/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import UIKit

class OwnerBoardViewController: UIViewController, UIAlertViewDelegate {
    var playerBoardView: OwnerBoardView?
    var board: GameBoard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Singleton.gameInstance.gameTurn == .player_one) {
            board = Singleton.gameInstance.boardPlayerOne
        }
        else {
            board = Singleton.gameInstance.boardPlayerTwo
        }
        
        playerBoardView = OwnerBoardView(frame: view.bounds, currentBoard: board!)
        view = playerBoardView
        view.backgroundColor = UIColor.init(red: 50/255 , green: 150/255 , blue: 1.0, alpha: 1.0)
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: screenWidth * 2 / 4, y: 30)
        label.textAlignment = NSTextAlignment.center
        label.text = "This is your sea map"
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
        
        let launchButton = UIButton(frame: CGRect(x: screenWidth * 2 / 4, y: screenHeight * 14 / 16, width: 120, height: 40))
        launchButton.backgroundColor = .gray
        launchButton.setTitle("Launch Missle", for: UIControlState())
        launchButton.addTarget(self, action: #selector(launchAction), for: .touchUpInside)
        self.view.addSubview(launchButton)
    }
    
    func launchAction(_ sender: UIButton!) {
        performSegue(withIdentifier: "selectingTarget", sender: nil)
        
    }
}
