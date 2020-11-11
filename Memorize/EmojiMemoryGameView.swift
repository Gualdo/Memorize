//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by De La Cruz, Eduardo on 04/11/2020.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        withAnimation(.linear(duration: flipAnimationDuration)) {
                            viewModel.choose(card: card)
                        }
                    }
                    .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            Button("New Game") {
                withAnimation(.easeInOut) { viewModel.resetGame() }
            }
        }
    }
    
    // MARK: - Drawing Constants
    
    private let flipAnimationDuration: Double = 0.75
}

// MARK: - CardView

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    private var pieRotationAngle: Double {
        card.isMatched ? 360 : 0
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    // MARK: - Custom Functions
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(pieStartAngle), endAngle: Angle.degrees(-animatedBonusRemaining * threeSixty - ninety), clockwise: true)
                            .onAppear {
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(pieStartAngle), endAngle: Angle.degrees(-card.bonusRemainig * threeSixty - ninety), clockwise: true)
                    }
                }
                .padding(piePadding)
                .opacity(pieOapacity)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(pieRotationAngle))
                    .animation(card.isMatched ? Animation.linear(duration: matchAnimationDuration).repeatForever(autoreverses: false) : .default) // Implicit animation
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * fontSizeScaleFactor
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemainig
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    // MARK: - Drawing Constants
    
    private let piePadding: CGFloat = 5
    private let fontSizeScaleFactor: CGFloat = 0.70
    private let pieStartAngle: Double = .zero - 90
    private let threeSixty: Double = 360
    private let ninety: Double = 90
    private let pieOapacity: Double = 0.40
    private let matchAnimationDuration: Double = 1
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
