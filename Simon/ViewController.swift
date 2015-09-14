//
//  ViewController.swift
//  Simon
//
//  Created by Aaron Weaver on 9/3/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StateObserver {
    
    private let timeBetweenButtonSequence = 0.5
    
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
    
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var highestScore: UILabel!
    
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    /// List containing the sequence of lights to indicate index in sequence
    private var sequenceLightList = [(UIImageView)]()
    
    private var sequenceLightIndex = 0
    
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
        
        updateScoreLabels()
        sequenceTimer(0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
        Single function to handle all button clicks from the view.
        This will handle ALL button taps for the view.
    */
    @IBAction func onGameButtonClicked(sender: UIButton) {
        switch sender.tag
        {
            case 0:
                self.gameLogic!.checkButtonPressedWithGameButton(GameButton.Red)
                print("Button Red")
                break
            case 1:
                self.gameLogic!.checkButtonPressedWithGameButton(GameButton.Yellow)
                print("Button Yellow")
                break
            case 2:
                self.gameLogic!.checkButtonPressedWithGameButton(GameButton.Green)
                print("Button Green")
                break
            case 3:
                self.gameLogic!.checkButtonPressedWithGameButton(GameButton.Blue)
                print("Button Blue")
                break
            case 4:
                self.gameLogic!.checkButtonPressedWithGameButton(GameButton.NewGame)
                print("New Game")
                break
            default:
                break
        }
    }
    
    private func sequenceTimer(index: Int)
    {
        disableUserInput()
        NSTimer.scheduledTimerWithTimeInterval(
            timeBetweenButtonSequence,
            target: self,
            selector: Selector("continueSequence:"),
            userInfo: index,
            repeats: false)
    }
    
    /**
        Discern correct button in a sequence to user.
        Uses NSTimer to delay between each button highlighting.
    */
    private func showSequenceToUser(currentIndex: Int)
    {
        let gameButton: GameButton = (self.gameLogic?.getButtonSequence()[currentIndex])!
        var buttonToShow: UIButton = UIButton()
        var imageName: String = ""
        
        switch(gameButton)
        {
            case GameButton.Red:
                imageName = "red-press"
                buttonToShow = self.redButton
                break
            case GameButton.Yellow:
                imageName = "yellow-press"
                buttonToShow = self.yellowButton
                break
            case GameButton.Green:
                imageName = "green-press"
                buttonToShow = self.greenButton
                break
            case GameButton.Blue:
                imageName = "blue-press"
                buttonToShow = self.blueButton
                break
            default:
                break
        }
        
        if let image = UIImage(named: imageName)
        {
            let originalImage = buttonToShow.imageView?.image
            
            /**
                Show button as highlighted.
            */
            buttonToShow.imageView?.image = image
            
            let params: [String: AnyObject] = ["gameButton": buttonToShow as AnyObject, "image": originalImage as! AnyObject, "index": currentIndex as AnyObject]
            
            // Start timer to unhighlight button.
            NSTimer.scheduledTimerWithTimeInterval(
                timeBetweenButtonSequence,
                target: self,
                selector: Selector("unlightSequenceButton:"),
                userInfo: params,
                repeats: false)
        }
    }
    
    /**
        Go-between for the NSTimer that continues to the next button in the sequence.
    */
    func continueSequence(timer: NSTimer)
    {
        let index = timer.userInfo as! Int
        showSequenceToUser(index)
    }
    
    /**
        Function called on timer to unhighlight a specific button within a sequence.
    */
    func unlightSequenceButton(timer: NSTimer)
    {
        let userInfo = timer.userInfo as! [String: AnyObject]
        let image = userInfo["image"] as! UIImage
        let button = userInfo["gameButton"] as! UIButton
        var index = userInfo["index"] as! Int
        
        button.imageView?.image = image
        
        if index < (self.gameLogic?.getButtonSequence().count)! - 1
        {
            index = index + 1
            // Make call to highlight next button in sequence.
            sequenceTimer(index)
        }
        else
        {
            enableUserInput()
        }
    }
    
    private func disableUserInput()
    {
        redButton.enabled = false
        redButton.setBackgroundImage(UIImage(named: "red"), forState: UIControlState.Disabled)
        blueButton.enabled = false
        blueButton.setBackgroundImage(UIImage(named: "blue"), forState: UIControlState.Disabled)
        yellowButton.enabled = false
        yellowButton.setBackgroundImage(UIImage(named: "yellow"), forState: UIControlState.Disabled)
        greenButton.enabled = false
        greenButton.setBackgroundImage(UIImage(named: "green"), forState: UIControlState.Disabled)
        newGameButton.enabled = false
        newGameButton.setBackgroundImage(UIImage(named: "new"), forState: UIControlState.Disabled)
    }
    
    private func enableUserInput()
    {
        redButton.enabled = true
        blueButton.enabled = true
        yellowButton.enabled = true
        greenButton.enabled = true
        newGameButton.enabled = true
    }
    
    /**
        Updates both score labels using values from GameLogic.
    */
    private func updateScoreLabels()
    {
        currentScore.text = String(gameLogic!.getCurrentScore())
        highestScore.text = String(gameLogic!.getHighScore())
    }
    
    private func lightSequenceLight(sequenceLight: UIImageView, index: Int, lightOn: Bool)
    {
        var imageName: String = ""
        
        if lightOn && index <= 6
        {
            imageName = "light-on-rotated"
        }
        else if lightOn
        {
            imageName = "light-on-rotated2"
        }
        else if !lightOn && index <= 6
        {
            imageName = "light-off-rotated"
        }
        else
        {
            imageName = "light-off-rotated2"
        }
        
        if let image = UIImage(named: imageName)
        {
            sequenceLight.image = image
        }
    }
    
    private func extinguishAllLights()
    {
        for var i = 0; i < sequenceLightList.count; i++
        {
            lightSequenceLight(sequenceLightList[i], index: i, lightOn: false)
        }
    }
    
    /// The methods below will be called upon an update in the game's status.
    /// Refer to the GameState enum in GameLogic for detailed description of each
    /// state, then decide on how to handle it with the UI.
    func onSequenceSuccess()
    {
        /// Handle for if the user successfully completes an entire sequence.
        // TODO: remove this
        print("success")
        self.lightSequenceLight(self.sequenceLightList[sequenceLightIndex], index: sequenceLightIndex, lightOn: true)
        sequenceLightIndex++
        updateScoreLabels()
        sequenceTimer(0)
    }
    
    func onGameFail()
    {
        /// Handle for if the user fails the game.
        // TODO: remove this
        print("fail")
        sequenceLightIndex = 0
        extinguishAllLights()
        updateScoreLabels()
        sequenceTimer(0)
    }
    
    func onGameRoundComplete()
    {
        /// Handle for if the user completes an entire round.
        print("round complete")
        extinguishAllLights()
        updateScoreLabels()
        sequenceTimer(0)
    }
    
    func onGameNewGame()
    {
        /// Handle for if user desires to start a new game.
        print("new game")
        extinguishAllLights()
        updateScoreLabels()
        sequenceTimer(0)
    }
}