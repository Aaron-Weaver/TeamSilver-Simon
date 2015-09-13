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
    
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var highestScore: UILabel!
    
    @IBOutlet weak var redButton: SOXShapedTapButton!
    @IBOutlet weak var yellowButton: SOXShapedTapButton!
    @IBOutlet weak var greenButton: SOXShapedTapButton!
    @IBOutlet weak var blueButton: SOXShapedTapButton!
    
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
        lightUpSequence((gameLogic?.getButtonSequence())!)
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
    
//    func lightUpSequence(sequenceList: [(GameButton)])
//    {
//        print("LIGHT UP SEQUENCE")
//        var imageName: String = ""
//        var buttonToShow: UIButton = UIButton()
//        
//        for var i = 0; i < sequenceList.count; i++
//        {
//            let gameButton: GameButton = sequenceList[i]
//            
//            switch(gameButton)
//            {
//                case GameButton.Red:
//                    imageName = "red-press"
//                    buttonToShow = self.redButton
//                    break
//                case GameButton.Yellow:
//                    imageName = "yellow-press"
//                    buttonToShow = self.yellowButton
//                    break
//                case GameButton.Green:
//                    imageName = "green-press"
//                    buttonToShow = self.greenButton
//                    break
//                case GameButton.Blue:
//                    imageName = "blue-press"
//                    buttonToShow = self.blueButton
//                    break
//                default:
//                    break
//            }
//            
//            print(imageName)
//            
//            if let image = UIImage(named: imageName)
//            {
//                //lightOnGameSequenceButton(buttonToShow, image: image)
//                let originalImage = buttonToShow.imageView?.image
//                
//                buttonToShow.imageView?.image = image
//                
//                buttonToShow.imageView?.image = originalImage
//            }
//        }
//    }
//    
//    func lightOnGameSequenceButton(button: UIButton, image: UIImage)
//    {
//        print("LIGHT ON GAME SEQUENCE")
//        let originalImage: UIImage = (button.imageView?.image)!
//        
//        button.imageView!.image = image
//        
//        sequenceLightTimer(button, image: originalImage)
//    }
//    
//    func lightOffGameSequenceButton(timer: NSTimer)
//    {
//        let userInfo = timer.userInfo as! [String:AnyObject]
//        let button = userInfo["gameButton"] as! UIButton
//        let image = userInfo["image"] as! UIImage
//        
//        button.imageView?.image = image
//    }
//    
//    func sequenceLightTimer(button: UIButton, image: UIImage)
//    {
//        let params: [String:AnyObject] = ["gameButton":button, "image":image]
//        
//        NSTimer.scheduledTimerWithTimeInterval(1.0,
//            target: self,
//            selector: Selector("lightOffGameSequenceButton:"),
//            userInfo: params,
//            repeats: false)
//    }
    
    /**
        Updates both score labels using values from GameLogic.
    */
    private func updateScoreLabels()
    {
        currentScore.text = String(gameLogic!.getCurrentScore())
        highestScore.text = String(gameLogic!.getHighScore())
    }
    
    /// The methods below will be called upon an update in the game's status.
    /// Refer to the GameState enum in GameLogic for detailed description of each
    /// state, then decide on how to handle it with the UI.
    func onSequenceSuccess()
    {
        /// Handle for if the user successfully completes an entire sequence.
        // TODO: remove this
        print("success")
        self.lightSequenceLight(self.sequenceLightList[sequenceLightIndex], lightOn: true, index: sequenceLightIndex)
        sequenceLightIndex++
        updateScoreLabels()
        lightUpSequence((gameLogic?.getButtonSequence())!)
    }
    
    func onGameFail()
    {
        /// Handle for if the user fails the game.
        // TODO: remove this
        print("fail")
        sequenceLightIndex = 0
        extinguishAllLights()
        updateScoreLabels()
    }
    
    func onGameRoundComplete()
    {
        /// Handle for if the user completes an entire round.
        print("round complete")
        extinguishAllLights()
        updateScoreLabels()
    }
    
    func onGameNewGame()
    {
        /// Handle for if user desires to start a new game.
        print("new game")
        extinguishAllLights()
        updateScoreLabels()
    }
}