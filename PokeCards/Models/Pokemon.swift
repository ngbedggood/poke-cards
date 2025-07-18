//
//  Pokemon.swift
//  PokeCards
//
//  Created by Nathaniel Bedggood on 15/07/2025.
//

import Foundation

struct Pokemon: Decodable {
    var name: String
    let sprites: Sprites
}

struct Sprites: Decodable {
    let front_default: String
}

struct PokemonSpecies: Decodable {
    let capture_rate: Int
}
