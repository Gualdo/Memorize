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
    
    private (set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue } }
    }
    
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
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
}

extension MemoryGame {
    
    struct Card: Identifiable {
        var id: Int
        var content: CardContent
        
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        //MARK: - Bonus Time
        
        /*
            This could give matching bonus points if the user matches the card
         before a certain amount of time passes during witch the card is face up
        */
        
        // Can be zero wich means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // The last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        /*
            The acumulated time this card has been face up in the past
         (i.e. not including the current time it's been face up if it is currently so)
         */
        var pastFaceUpTime: TimeInterval = 0
        
        // How long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // How much time left before the bonus opportunity runs out
        var bonusTimeRemaining: Double {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // Percentage of the bonus time remaining
        var bonusRemainig: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // Whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // Whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // Called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // Called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}
