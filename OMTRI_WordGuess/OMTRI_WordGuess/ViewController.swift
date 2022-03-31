//
//  ViewController.swift
//  OMTRI_WordGuess
//
//  Created by Omtri,Homakesavadurgaprasad on 3/30/22.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var totalWordsLabel: UILabel!
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var guessLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var wordsToGuess = [
                        ["NEWYORK","EMPIRE STATE"],
                        ["MISSOURI","SHOW ME STATE"],
                        ["IPHONE","STEVE JOBS"],
                        ["FLORIDA","SUNSHINE STATE"],
                        ["KANSAS","SUNFLOWER STATE"]
                        ]
    var hintWord = ""
    var imageArray = ["newyork","missouri","apple","miami","kansas"]
    var word = ""
    var wordIterator = 0
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 10
    var guessesLeft = 10
    var count = 0
    var guessedWordsCount = 0
    var missedWordsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        word = wordsToGuess[wordIterator][0]
        hintWord = wordsToGuess[wordIterator][1]
        hintLabel.text = "HINT: " + hintWord
        wordsGuessedLabel.text = "Words Guessed: 0"
        wordsMissedLabel.text = "Words Missed: 0"
        totalWordsLabel.text = "Words in Game: \(wordsToGuess.count)"
        wordsRemainingLabel.text = "Words Remaining: \(wordsToGuess.count)"
        printUserGuessLabel()
        guessLetterButton.isEnabled = false
        
        playAgainButton.isHidden = true
    }
    func updateLabels(){
        
        wordsMissedLabel.text = "Words Missed: \(missedWordsCount)"
        wordsGuessedLabel.text = "Words Guessed: \(guessedWordsCount)"
        
        wordsRemainingLabel.text = "Words Remaining:\(wordsToGuess.count - (guessedWordsCount + missedWordsCount))"
    }
    
    func keyBoardDown(){
        
        guessLetterField.resignFirstResponder()
        
        guessLetterField.text = ""
    }
    
    func printUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessLetterField.text!
        
        for letter in word {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    
    
    func guessLetter() {
        printUserGuessLabel()
        count += 1
        
        
        let tempLetterGuessed = guessLetterField.text!
        
        if !word.contains(tempLetterGuessed) {
            
            guessesLeft = guessesLeft - 1
            
        }
        
        let revealedWord = userGuessLabel.text!
        
        if guessesLeft == 0 {
            
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            
            guessCountLabel.text = "You're all out of guesses. Try again?"
            missedWordsCount += 1
            updateLabels()
            updateImageView()
        } else if !revealedWord.contains("_") {
           
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(count) guesses to guess it!"
            guessedWordsCount += 1
            updateLabels()
            updateImageView()
        } else {
            // Update our guess count
            let guess = ( count == 1 ? "Guess" : "Guesses")
            guessCountLabel.text = "You've Made \(count) \(guess)"
        }
        
        if (guessedWordsCount + missedWordsCount) == wordsToGuess.count {
            guessCountLabel.text = "You've tried all of the words! Restart from the beginning?"
            updateImageView()
        }
    }
    
  
    
    
    @IBAction func guessLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessLetterField.text?.last {
            guessLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessLetter()
        keyBoardDown()
        let letter = guessLetterField.text
        if letter?.isEmpty == true{
            guessLetterButton.isEnabled = false
        }
        else{
            guessLetterButton.isEnabled = true
        }
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        
        guessLetter()
        keyBoardDown()
        let letter = guessLetterField.text
        if letter?.isEmpty == true{
            guessLetterButton.isEnabled = false
        }
        else{
            guessLetterButton.isEnabled = true
        }
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        imageView.isHidden = true
        wordIterator += 1
        if wordIterator == wordsToGuess.count {
            wordIterator = 0
            guessedWordsCount = 0
            missedWordsCount = 0
            updateLabels()
        }
        word = wordsToGuess[wordIterator][0]
        hintWord = wordsToGuess[wordIterator][1]
        hintLabel.text = "HINT: " + hintWord
        
        playAgainButton.isHidden = true
        guessLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        
        guessesLeft = maxNumberOfWrongGuesses
        lettersGuessed = ""
        printUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses"
        count = 0
    }
    
            func updateImageView(){
                imageView.isHidden = false
                imageView.image = UIImage(named: imageArray[wordIterator])
                let originalImageFrame = imageView.frame
                let widthShrink: CGFloat = 10
                let heightShrink: CGFloat = 10
                let newFrame = CGRect(
                x: imageView.frame.origin.x + widthShrink,
                y: imageView.frame.origin.y + heightShrink,
                width: imageView.frame.width - widthShrink,
                height: imageView.frame.height - heightShrink)
                imageView.frame = newFrame
                UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0,  animations: {
                    self.imageView.frame = originalImageFrame
                })
}

}
