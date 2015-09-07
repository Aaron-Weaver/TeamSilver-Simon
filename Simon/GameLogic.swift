//
//  GameLogic.swift
//  Simon
//
//  Created by Aaron Weaver on 9/7/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

/**
    Color coded buttons that can be pressed by player to match a specified sequence.

    - Red Button.
    - Yellow Button.
    - Green Button.
    - Blue Button.
*/
public enum GameButton
{
    case Red
    case Yellow
    case Green
    case Blue
}

/**
    Representation of the game state after a user has performed an action.

    - Success: Reflects player's successful completion of an entire sequence.
    - Fail: Reflects player's failure to recreate the proper sequence.
    - NewRound: Reflects player's completion of an entire round.
    - CorrectMatch: Reflects player's completion of a single step of the proper sequence.
*/
public enum GameState
{
    case Success
    case Fail
    case NewRound
    case CorrectMatch
}

/// All logic that is performed for the Simon game.
class GameLogic
{
    /// Scores for Simon game.
    private struct Scores
    {
        /// Highest score since opening the application.
        static var highestScore = 0
        
        /// Current score for the round.
        static var currentScore = 0
    }
    
    /// List containing the proper sequence of button presses for the current game.
    private var sequenceList = [(GameButton)]()
    
    /// Represents the games current state.
    private var currentGameState = GameState.NewRound
    
    /// Current index within the game's generated sequence.
    private var currentSequenceIndex = 0
    
    /// Max number of possible buttons in a sequence per round.
    let maxSequenceItemNum = 12
    
    /** 
        Initialize GameLogic with a single random button in the game sequence.
    
        :returns: GameLogic with a single button in the sequence.
    */
    init()
    {
        addRandomButtonToSequence()
    }
    
    /** 
        Add a random button to the sequence list.
    */
    func addRandomButtonToSequence()
    {
        let randomInt = Int(arc4random_uniform(4))
        
        switch(randomInt)
        {
            case 0:
                sequenceList.append(GameButton.Red)
                break;
            case 1:
                sequenceList.append(GameButton.Yellow)
                break;
            case 2:
                sequenceList.append(GameButton.Green)
                break;
            case 3:
                sequenceList.append(GameButton.Blue)
                break;
            default:
                sequenceList.append(GameButton.Blue)
                break;
        }
    }
    
    /**
        Remove all buttons from the sequence then add one to the now empty sequence.
    */
    private func resetSequence()
    {
        currentSequenceIndex = 0
        sequenceList.removeAll()
        addRandomButtonToSequence()
    }
    
    /**
        Perform a game logic operation based on the current state of the game.
    */
    private func checkGameState()
    {
        switch(currentGameState)
        {
            /// Reset sequence index and update scores to reflect completion of a sequence.
            case GameState.Success:
                currentSequenceIndex = 0
                Scores.currentScore++
                
                if Scores.highestScore < Scores.currentScore
                {
                   Scores.highestScore = Scores.currentScore
                }
                
                addRandomButtonToSequence()
                break
            
            /// Reset back to initial game state and update score to reflect a fail state.
            case GameState.Fail:
                Scores.currentScore = 0
                resetSequence()
                break
            
            /// Reset back to initial game state and update score to reflect a round win.
            case GameState.NewRound:
                Scores.highestScore = maxSequenceItemNum
                resetSequence()
                break
            
            /// Add to sequence index after making a correct match within the proper sequence.
            case GameState.CorrectMatch:
                currentSequenceIndex++
                break
        }
    }
    
    /**
        Check the user's pressed button against the proper button in the sequence, then determine the
        game state.
    
        :param: button The button pressed by the user.
    
        :returns: The game state after button pressed is analyzed.
    */
    func checkSequenceWithGameButton(button: GameButton) -> GameState
    {
        if sequenceList[currentSequenceIndex] == button
        {
            if currentSequenceIndex == maxSequenceItemNum - 1
            {
                //return GameState.NewRound
                self.currentGameState = GameState.NewRound
            }
            else if currentSequenceIndex == sequenceList.count - 1
            {
                self.currentGameState = GameState.Success
            }
            else
            {
                self.currentGameState = GameState.CorrectMatch
            }
        }
        else
        {
            self.currentGameState = GameState.Fail
        }
        
        checkGameState()
        
        return currentGameState
    }
    
    func getHighScore() -> Int
    {
        return Scores.highestScore
    }
    
    func getCurrentScore() -> Int
    {
        return Scores.currentScore
    }
    
    func getButtonSequence() -> [(GameButton)]
    {
        return sequenceList
    }
}