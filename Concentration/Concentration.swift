//
//  Concentration.swift
//  Concentration
//
//  Created by Mario Krajačić on 14/03/2020.
//  Copyright © 2020 Mario Krajačić. All rights reserved.
//

import Foundation
struct Concentration {
    // private(set) jer sam setiram podatak, drugi ga smiju samo pogledati (get)
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
//            dodan closure unutar {}
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    // mutating dodajem ispred funkcije jer sam clasu pretvorio u struct. Struct je reference type i funkcije trebaju biti mutable
    mutating func chooseCard(at index: Int) {
        // assert is for debugging and testing purposes
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isFaceUp {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // Check if cards mach
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
    
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
