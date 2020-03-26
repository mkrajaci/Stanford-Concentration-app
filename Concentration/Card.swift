//
//  Card.swift
//  Concentration
//
//  Created by Mario Krajačić on 14/03/2020.
//  Copyright © 2020 Mario Krajačić. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int { return identifier }
//    func hash(into hasher: inout Hasher) {
//        return identifier
//    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
