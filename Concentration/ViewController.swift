//
//  ViewController.swift
//  Concentration
//
//  Created by Mario Krajačić on 09/03/2020.
//  Copyright © 2020 Mario Krajačić. All rights reserved.
//

import UIKit

// ViewController is my class who inherits UIViewController class
// UIViewController super class from UIKit which understand and manipulate with all UI in the app

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    var flipCount = 0 {
        // didSet observeing flipCount and whet it changes, didSet will execute
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    // _ External name, sender internal name
    @IBAction func touchCard(_ sender: UIButton) {
         flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Error")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.6156862745, green: 0.1019607843, blue: 0.1019607843, alpha: 0.978702911)
            }
        }
    }
    
    var emojiChoices = ["✝️", "✞", "✝︎", "☦︎", "♰", "😇",]
    // deklariranje dictionarya
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        // ugnjezdeni if odnojim zarezom i tako i citam slijedno, jednostavnije je
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            // .remove koristim da makne emoji koji je koristio kako se on ne bi ponovio
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        // vrati emoji[card.identifier] a ako je nil vrati ?
        return emoji[card.identifier] ?? "?"
    }

}

