//
//  MemoryGame.swift
//  Memorize
//
//  Created by De La Cruz, Eduardo on 04/11/2020.
//

//            var faceUpCardIndices = [Int]()
//
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
            
            // All the above is simplified with the line 18 using filter on the cards array
            
//            let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }
            
//            if faceUpCardIndices.count == 1 {
//                return faceUpCardIndices.first
//            } else {
//                return nil
//            }
            
            // All the above is simplified with the the Array+Only extension and line 28
            
//            return faceUpCardIndices.only
            
            // Lines 18 and 28 are simplied with the line 45 so we finally get only 1 line of code

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var seen: Bool = false
        var content: CardContent
    }
    
    var cards: Array<Card>
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach {
            if cards[$0].isFaceUp {
                cards[$0].seen = true
            }
            cards[$0].isFaceUp = $0 == newValue }
        }
    }
    var points: Int = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: (pairIndex * 2) + 1, content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    points += 2
                } else {
                    if cards[chosenIndex].seen {
                        points -= 1
                    }
                    if cards[potentialMatchIndex].seen {
                        points -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
}
