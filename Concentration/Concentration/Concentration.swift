//
//  Concentration.swift
//  Concentration
//
//  Created by Jeson Rosario on 9/5/19.
//  Copyright © 2019 Jeson Rosario. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    var flipCount = 0
    var score = 0
    var gameClock = Clock()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly
            
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        print(gameClock.time)
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // Check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                // Check if card has been. If so, penalize.
                if !cards[index].isMatched && (cards[matchIndex].isSeen || cards[index].isSeen) {
                    score -= 1
                }
                cards[matchIndex].isSeen = true
                cards[index].isSeen = true
                cards[index].isFaceUp = true
                
            } else {
                // No cards or 2 are facep up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
            flipCount += 1
    }
    
//    mutating func bonusPoints() {
//        if gameClock.time >= 30 { score += 60 }
//        if gameClock.time >= 45 { score += 45 }
//        if gameClock.time >= 60 { score += 30 }
//    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // Shuffles cards
        for _ in cards.indices {
            let shuffledCards = Int(arc4random_uniform(UInt32(cards.count)))
            cards.append(cards.remove(at: shuffledCards))
        }
        // cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
