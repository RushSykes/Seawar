//
//  InitBoardViewController.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import UIKit

// This controller takes responsibility to
// display the initializing process to the screen
class InitBoardViewController: UIViewController, UIAlertViewDelegate {
    
    var playerBoardView: InitBoardView?
    var imgs = [UIImageView: Int]()
    var currentImg: UIImageView?
    var popUpMsg: UIAlertView = UIAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popUpMsg.addButton(withTitle: "OK")
        
        playerBoardView = InitBoardView(frame: view.bounds, currentBoard: GameBoard())
        
        // So the current view you'll see is the playerBoard
        view = playerBoardView
        view.backgroundColor = UIColor.init(red: 50/255 , green: 150/255 , blue: 1.0, alpha: 1.0)
        
        // Put the sample icon of each ship at the buttom
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        // Initialize each icon as imgview
        let imageView1
            = UIImageView(frame: CGRect(x: screenWidth / 16, y: screenHeight * 10 / 16, width: 73, height: 38))
        let image1 = UIImage(named: "ship2.png")
        imageView1.image = image1
        
        let imageView2
            = UIImageView(frame: CGRect(x: screenWidth / 16, y: screenHeight * 11 / 16 + 8, width: 110, height: 37))
        let image2 = UIImage(named: "ship3.png")
        imageView2.image = image2
        
        let imageView3
            = UIImageView(frame: CGRect(x: screenWidth / 16, y: screenHeight * 12 / 16 + 16, width: 110, height: 37))
        let image3 = UIImage(named: "ship3.png")
        imageView3.image = image3
        
        let imageView4
            = UIImageView(frame: CGRect(x: screenWidth / 2 - 20, y: screenHeight * 11 / 16 + 8, width: 144, height: 36))
        let image4 = UIImage(named: "ship4.png")
        imageView4.image = image4
        
        let imageView5
            = UIImageView(frame: CGRect(x: screenWidth / 2 - 20, y: screenHeight * 12 / 16 + 16, width: 180, height: 40))
        let image5 = UIImage(named: "ship5.png")
        imageView5.image = image5
        
        // Fill the dictionary's value
        imgs[imageView1] = 2
        imgs[imageView2] = 3
        imgs[imageView3] = 3
        imgs[imageView4] = 4
        imgs[imageView5] = 5
        
        for img in imgs.keys {
            img.alpha = 0.7
            img.isUserInteractionEnabled = true
            img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(InitBoardViewController.imageTapped(_:))))
            self.view.addSubview(img)
        }
        
        let label = UILabel(frame: CGRect(x: 0, y:0, width: 300, height: 21))
        label.center = CGPoint(x: screenWidth * 2 / 4, y: 30)
        label.textAlignment = NSTextAlignment.center
        label.text = "Please put 17 ship blocks in the map"
        self.view.addSubview(label)
        
        let playerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
        playerLabel.center = CGPoint(x: screenWidth / 2, y: screenHeight * 10 / 16)
        playerLabel.textAlignment = NSTextAlignment.center
        if (Singleton.gameInstance.gameTurn == .player_one){
            playerLabel.text = "Player 1"
        }
        else{
            playerLabel.text = "Player 2"
        }
        self.view.addSubview(playerLabel)
        
        let randomButton = UIButton(frame: CGRect(x: screenWidth * 1 / 4, y: screenHeight * 14 / 16, width: 80, height: 40))
        randomButton.backgroundColor = .gray
        randomButton.setTitle("Random", for: UIControlState())
        randomButton.addTarget(self, action: #selector(randomAction), for: .touchUpInside)
        self.view.addSubview(randomButton)
        
        let nextButton = UIButton(frame: CGRect(x: screenWidth * 2 / 4, y: screenHeight * 14 / 16, width: 80, height: 40))
        nextButton.backgroundColor = .gray
        nextButton.setTitle("Ready", for: UIControlState())
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        let resetButton = UIButton(frame: CGRect(x: screenWidth * 3 / 4, y: screenHeight * 14 / 16, width: 80, height: 40))
        resetButton.backgroundColor = .gray
        resetButton.setTitle("Reset", for: UIControlState())
        resetButton.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        self.view.addSubview(resetButton)
    }
    
    func randomAction(_ sender: UIButton!) {
        playerBoardView?.playerShips.resetStatus()
        playerBoardView?.playerShips.randomize()
    }
    
    func nextAction(_ sender: UIButton!) {
        if(!(playerBoardView?.playerShips.verifyShips())!) {
            
            wrongMsg()
        }
        else {
            if(Singleton.gameInstance.gameTurn == .player_two ) {
                Singleton.gameInstance.gameTurn = .player_one
                playerBoardView?.playerShips.updateGridStatus()
                Singleton.gameInstance.boardPlayerTwo = (playerBoardView?.board)!
                Singleton.gameInstance.isReady = true
                performSegue(withIdentifier: "boardsReady", sender: nil)
            } else {
                Singleton.gameInstance.gameTurn = .player_two
                playerBoardView?.playerShips.updateGridStatus()
                Singleton.gameInstance.boardPlayerOne = (playerBoardView?.board)!
                performSegue(withIdentifier: "nextPlayer", sender: nil)
            }
        }
    }
    
    func wrongMsg() {
        popUpMsg.title = "You must have exactly 17 ship blocks in the map!"
        popUpMsg.show()
    }
    
    func resetAction(_ sender: UIButton!) {
        playerBoardView?.playerShips.resetStatus()
    }
    
    func imageTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        let tappedImg = gestureRecognizer.view!
        currentImg = tappedImg as? UIImageView
        for img in imgs.keys {
            if (img == tappedImg) {
                img.alpha = 1
            } else {
                img.alpha = 0.7
            }
        }
    }

}
