//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by De La Cruz, Eduardo on 04/11/2020.
//

import SwiftUI

class EmojiMemoryGame {
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var fontType: Font { // Assignment 1.5
        return model.cards.count == 10 ? Font.body : Font.largeTitle
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    // MARK: - Custom Functions
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻","🎃", "🕷", "☠️", "🕸"] // Assignment 1.4
        let randomNumbersOfPairs = Int.random(in: 2..<6) // Assignment 1.4
        return MemoryGame<String>(numberOfPairsOfCards: randomNumbersOfPairs) { pairIndex in
            return emojis[pairIndex]
        }
    }
}
