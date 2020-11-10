//
//  Cardify.swift
//  Memorize
//
//  Created by De La Cruz, Eduardo on 10/11/2020.
//

import SwiftUI

struct Cardify {
    
    var isFaceUp: Bool
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}

// MARK: - ViewModifier protocol implementation

extension Cardify: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
            }
        }
    }
}

// MARK: - View extension to call .cardify

extension View {
    
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
