//
//  ViewController.swift
//  Simon
//
//  Created by Aaron Weaver on 9/3/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StateObserver {
    
    /// Declare delegates for sequence lights
    @IBOutlet weak var sequenceLight1: UIImageView!
    @IBOutlet weak var sequenceLight2: UIImageView!
    @IBOutlet weak var sequenceLight3: UIImageView!
    @IBOutlet weak var sequenceLight4: UIImageView!
    @IBOutlet weak var sequenceLight5: UIImageView!
    @IBOutlet weak var sequenceLight6: UIImageView!
    @IBOutlet weak var sequenceLight7: UIImageView!
    @IBOutlet weak var sequenceLight8: UIImageView!
    @IBOutlet weak var sequenceLight9: UIImageView!
    @IBOutlet weak var sequenceLight10: UIImageView!
    @IBOutlet weak var sequenceLight11: UIImageView!
    @IBOutlet weak var sequenceLight12: UIImageView!
    
    
    /// List containing the sequence of lights to indicate index in sequence
    private var sequenceLightList = [(UIImageView)]()
    
    /// Logic object for the Simon game.
    var gameLogic: GameLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLogic = GameLogic(stateObserver: self)
        sequenceLightList.append(sequenceLight1)
        sequenceLightList.append(sequenceLight2)
        sequenceLightList.append(sequenceLight3)
        sequenceLightList.append(sequenceLight4)
        sequenceLightList.append(sequenceLight5)
        sequenceLightList.append(sequenceLight5)
        sequenceLightList.append(sequenceLight6)
        sequenceLightList.append(sequenceLight7)
        sequenceLightList.append(sequenceLight8)
        sequenceLightList.append(sequenceLight9)
        sequenceLightList.append(sequenceLight10)
        sequenceLightList.append(sequenceLight11)
        sequenceLightList.append(sequenceLight12)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onRedButtonTouchUp(sender: UIButton) {
        self.gameLogic!.checkButtonPressedWithGameButton(GameButton.Red)
    }
    
    @IBAction func onYellowButtonTouchUp(sender: UIButton) {
        self.gameLogic!.checkButtonPressedWithGameButton(GameButton.Yellow)
    }
    @IBAction func onGreenButtonTouchUp(sender: UIButton) {
        self.gameLogic!.checkButtonPressedWithGameButton(GameButton.Green)
    }
    @IBAction func onBlueButtonTouchUp(sender: UIButton) {
        self.gameLogic!.checkButtonPressedWithGameButton(GameButton.Blue)
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
    
    /// The methods below will be called upon an update in the game's status.
    /// Refer to the GameState enum in GameLogic for detailed description of each
    /// state, then decide on how to handle it with the UI.
    func onSequenceSuccess()
    {
        /// Handle for if the user successfully completes an entire sequence.
        // TODO: remove this
        print("success")
    }
    
    func onGameFail()
    {
        /// Handle for if the user fails the game.
        // TODO: remove this
        print("fail")
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
        sequenceLightList[gameLogic!.getButtonSequence().count - 1].image = UIImage(named: "light-on-rotated")
        /// Handle for if user has managed a correct single match within a sequence.
        /// We might not need this one, I just have it for posterity's sake.
        /// Feel free to remove this method if you do not use it.
        print("correct")
    }
}