//
//  Theme.swift
//  Memorize
//
//  Created by De La Cruz, Eduardo on 09/11/2020.
//

import SwiftUI

enum Theme: CaseIterable {
    case halloween
    case animals
    case sports
    case faces
    case food
    case vehicles
    
    var themeData: (name: String, color: Color, emojis: [String]) {
        switch self {
        case .halloween:
            return ("Halloween", .orange, ["👻","🎃", "🕷", "🕸", "☠️", "🧟‍♂️"])
        case .animals:
            return ("Animals", .green, ["🦒", "🦖", "🦢", "🦕", "🐄", "🦜"])
        case .sports:
            return ("Sports", .blue, ["🎾", "🏈", "⚾️", "🏓", "🏀", "⛸"])
        case .faces:
            return ("Faces", .yellow, ["😂", "🤪", "😍", "😎", "😇", "🥳"])
        case .food:
            return ("Food", .purple, ["🍌", "🍓", "🧀", "🍎", "🍕", "🍰"])
        case .vehicles:
            return ("Vehicles", .red, ["🚙", "✈️", "🚒", "🚑", "🚛", "🚤"])
        }
    }
}
