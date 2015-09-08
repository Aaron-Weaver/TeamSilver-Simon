//
//  ViewController.swift
//  Simon
//
//  Created by Aaron Weaver on 9/3/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gameLogic = GameLogic()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// Example use of the game logic against a button press.
    func redButtonClicked(sender: UIButton)
    {
        /// Function returns a game state that can then be handled by the UI.
        let gameState = self.gameLogic.checkSequenceWithGameButton(GameButton.Red)
        
        /// Handle your game state somehow. List of game states and their descriptions is available
        /// in the GameLogic.swift class.
        handleUIWithGameState(gameState)
    }
    
    /// Example use of game logic to re-start game.
    func newGameClicked(sender: UIButton)
    {
        self.gameLogic.reinitializeGame()
    }

    private func handleUIWithGameState(gameState: GameState)
    {
        // Handle game state with UI here.
    }
    
    private func showSequenceToUser()
    {
        let sequence = self.gameLogic.getButtonSequence()
        
        /// Handle showing the sequence to the user.
    }
}

