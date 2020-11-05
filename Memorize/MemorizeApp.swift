//
//  MemorizeApp.swift
//  Memorize
//
//  Created by De La Cruz, Eduardo on 04/11/2020.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
