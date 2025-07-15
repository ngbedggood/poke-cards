//
//  Item.swift
//  PokeCards
//
//  Created by Nathaniel Bedggood on 15/07/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
