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
        var cardNumber = cardButtons.index(of: <#T##UIButton#>)
    }

    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }

}

