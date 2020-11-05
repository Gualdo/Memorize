//
//  ContentView.swift
//  Memorize
//
//  Created by De La Cruz, Eduardo on 04/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                GeometryReader { geometry in // Assignment 1.3
                    CardView(card: card, height: geometry.size.width * 1.5) // Assignment 1.3
                        .onTapGesture {
                            viewModel.choose(card: card)
                        }
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(viewModel.fontType) // Assignment 1.5
    }
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    var height: CGFloat // Assignment 1.3
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill()
            }
        }
        .frame(height: height) // Assignment 1.3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
