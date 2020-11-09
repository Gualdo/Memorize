//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by De La Cruz, Eduardo on 04/11/2020.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static var theme: Theme = Theme.allCases.randomElement()!
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var title: String {
        return "Memorize: \(EmojiMemoryGame.theme.themeData.name)"
    }
    
    var themeColor: Color {
        return EmojiMemoryGame.theme.themeData.color
    }
    
    var points: Int {
        model.points
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    // MARK: - Custom Functions
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = theme.themeData.emojis
        let randomNumberOfPairs = Int.random(in: 2...emojis.count)
        return MemoryGame<String>(numberOfPairsOfCards: randomNumberOfPairs) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    func createNewGame() {
        EmojiMemoryGame.theme = Theme.allCases.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame()
    }
}
