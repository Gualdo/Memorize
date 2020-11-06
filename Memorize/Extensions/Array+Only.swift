//
//  Array+Only.swift
//  Memorize
//
//  Created by De La Cruz, Eduardo on 06/11/2020.
//

import Foundation

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
}
