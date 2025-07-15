//
//  PokeViewModel.swift
//  PokeCards
//
//  Created by Nathaniel Bedggood on 15/07/2025.
//

import Combine
import Foundation

class PokeViewModel: ObservableObject {

    @Published var pokemon: Pokemon?

    func fetchRandomPokemon() {
        let randomID = Int.random(in: 1...1010)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"

        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    self.pokemon = try JSONDecoder().decode(
                        Pokemon.self, from: data)
                } catch {
                    print("Decode error: \(error)")
                }
            }
        }.resume()

    }

    func fetchDitto() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/ditto")
        else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    self.pokemon = try JSONDecoder().decode(
                        Pokemon.self, from: data)
                } catch {
                    print("Decode error: \(error)")
                }
            }
        }.resume()
    }

}
