//
//  ViewController.swift
//  Concentration
//
//  Created by Jeson Rosario on 8/28/19.
//  Copyright © 2019 Jeson Rosario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var numberOfPairsOfCards: Int {
         return (cardButtons.count + 1) / 2
    }

    private var emojiChoices = "👻🎃☠️😈😱🙀🧟‍♂️🕸🍭"
    
    private var currentColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    
    override func viewDidLoad() {
        game.gameClock.start()
        // Creates broder around new game button corresponding to theme
        newGameLabel.layer.borderColor = currentColor.cgColor
        newGameLabel.layer.borderWidth = 2
        newGameLabel.layer.cornerRadius = 16
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet weak var newGameLabel: UIButton!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            print("cardNumber = \(cardNumber)")
            game.chooseCard(at: cardNumber )
            updateViewFromModel()
        } else {
            print("Chosen card not found in cardButtons")
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)    // Resets the cards
        let randomNum = Int(arc4random_uniform(6))                          // Generates a random number
        let theme = Theme(rawValue: randomNum)                              // Chooses a random theme
        themeColors(num: randomNum)                                         // Sets colors for the chosen theme
        game.gameClock.reset()                                              // Resets the game clock
        game.gameClock.start()                                              // Starts the game clock
        updateViewFromModel()                                               // Flips cards back down
        emojiChoices = (theme?.themeChooser())!                             // Overrides the init emojiChoices upon reset
        game.flipCount = 0
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeColor : currentColor,
            .strokeWidth : -5.0
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)",
                                                  attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : currentColor
            }
        }
        updateFlipCountLabel()
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private var emoji = [Card:String]()
    
    private func emoji (for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = String(emojiChoices.remove(at: emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)))
        }
        return emoji[card] ?? "?"
    }
    
    private func themeColors(num: Int) {
        // Changes the colors to correspond with theme
        switch (num) {
        
        // Halloween
        case 0:
            currentColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            flipCountLabel.textColor = currentColor
            scoreLabel.textColor = currentColor
            newGameLabel.setTitleColor(currentColor, for: .normal)
            newGameLabel.layer.borderColor = currentColor.cgColor
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // Animals
        case 1:
            currentColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            flipCountLabel.textColor = currentColor
            scoreLabel.textColor = currentColor
            newGameLabel.setTitleColor(currentColor, for: .normal)
            newGameLabel.layer.borderColor = currentColor.cgColor
            self.view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        // Food
        case 2:
            currentColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            flipCountLabel.textColor = currentColor
            scoreLabel.textColor = currentColor
            newGameLabel.setTitleColor(currentColor, for: .normal)
            newGameLabel.layer.borderColor = currentColor.cgColor
            self.view.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            
        // Sports
        case 3:
            currentColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            flipCountLabel.textColor = currentColor
            scoreLabel.textColor = currentColor
            newGameLabel.setTitleColor(currentColor, for: .normal)
            newGameLabel.layer.borderColor = currentColor.cgColor
            self.view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            
        // Faces
        case 4:
            currentColor = #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)
            flipCountLabel.textColor = currentColor
            scoreLabel.textColor = currentColor
            newGameLabel.setTitleColor(currentColor, for: .normal)
            newGameLabel.layer.borderColor = currentColor.cgColor
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)

        // Vehicles
        case 5:
            currentColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            flipCountLabel.textColor = currentColor
            scoreLabel.textColor = currentColor
            newGameLabel.setTitleColor(currentColor, for: .normal)
            newGameLabel.layer.borderColor = currentColor.cgColor
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        default:
            break
        }
    }

}

extension Int {
    var arc4random:Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
