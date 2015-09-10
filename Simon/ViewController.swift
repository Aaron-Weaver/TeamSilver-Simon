//
//  ViewController.swift
//  Simon
//
//  Created by Aaron Weaver on 9/3/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StateObserver {

    @IBOutlet weak var redButtonBackground: UIImageView!
    @IBOutlet weak var yellowButtonBackground: UIImageView!
    @IBOutlet weak var greenButtonBackground: UIImageView!
    @IBOutlet weak var blueButtonBackground: UIImageView!
    /// Logic object for the Simon game.
    var gameLogic: GameLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLogic = GameLogic(stateObserver: self)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// Example use of the game logic against a button press.
    func buttonClicked(sender: UIButton)
    {
        /// Find out which button was pressed.
        var buttonPressed: GameButton
        buttonPressed = GameButton.Red
        
        /// Function returns a game state that can then be handled by the UI.
        self.gameLogic!.checkButtonPressedWithGameButton(buttonPressed)
    }
    
    @IBAction func redButtonPressDown(sender: UIButton) {
        redButtonBackground.image = UIImage(named: "red-press")
    }
    @IBAction func redButtonPress(sender: UIButton) {
        print("RED")
        redButtonBackground.image = UIImage(named: "red")
    }
    
    /// The methods below will be called upon an update in the game's status.
    /// Refer to the GameState enum in GameLogic for detailed description of each
    /// state, then decide on how to handle it with the UI.
    func onGameSuccess()
    {
        /// Handle for if the user successfully completes an entire sequence.
    }
    
    func onGameFail()
    {
        /// Handle for if the user fails the game.
    }
    
    func onGameRoundComplete()
    {
        /// Handle for if the user completes an entire round.
    }
    
    func onGameNewGame()
    {
        /// Handle for if user desires to start a new game.
    }
    
    func onGameCorrectMatch()
    {
        /// Handle for if user has managed a correct single match within a sequence.
        /// We might not need this one, I just have it for posterity's sake.
        /// Feel free to remove this method if you do not use it.
    }
}