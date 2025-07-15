//
//  Pokemon.swift
//  PokeCards
//
//  Created by Nathaniel Bedggood on 15/07/2025.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let sprites: Sprites
}

struct Sprites: Decodable {
    let front_default: String
}
