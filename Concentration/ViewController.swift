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
    // private jer je numberOfPairsOfCards usko vezan uz UI
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    // private(set) jer ne zelim da drugi set-iraju vrijednost
    private(set) var flipCount = 0 {
        // didSet observeing flipCount and whet it changes, didSet will execute
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    
    // _ External name, sender internal name
    @IBAction private func touchCard(_ sender: UIButton) {
         flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Error")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.6156862745, green: 0.1019607843, blue: 0.1019607843, alpha: 0.978702911)
            }
        }
    }
    
    // mozda u buducnosti maknuti private kako bi izvana mogao specificirati koje slike se koriste
    private var emojiChoices = ["✝️", "✞", "✝︎", "☦︎", "♰", "😇", "😘", "🥶", "☀︎", "😎", "🙌", "💪"]
    // deklariranje dictionarya
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
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

