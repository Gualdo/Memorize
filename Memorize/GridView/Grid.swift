//
//  Grid.swift
//  Memorize
//
//  Created by De La Cruz, Eduardo on 05/11/2020.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(items) { item in
                Group {
                    let gridLayout: GridLayout = GridLayout(itemCount: items.count, in: geometry.size)
                    if let index = items.firstIndex(matching: item) {
                        viewForItem(item)
                            .frame(width: gridLayout.itemSize.width, height: gridLayout.itemSize.height)
                            .position(gridLayout.location(ofItemAt: index))
                    }
                }
            }
        }
    }
}
