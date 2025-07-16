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
    @Published var isLoading: Bool = false

    
    func fetchRandomPokemon() async throws {
        isLoading = true
        let randomID = Int.random(in: 1...151)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"

        guard let url = URL(string: urlString) else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
            DispatchQueue.main.async {
                self.pokemon = decoded
                self.pokemon?.name = self.formatName(self.pokemon?.name ?? "")
                self.isLoading = false
            }
        } catch {
            print("Error:", error)
            isLoading = false
        }

    }
    
    func formatName(_ name: String) -> String {
        let base = name.split(separator: "-").first ?? ""
        return base.prefix(1).capitalized + base.dropFirst()
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
