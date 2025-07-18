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
    @Published var tokens: Double = 5.0
    
    private var species: PokemonSpecies?
    
    func fetchRandomPokemon() async throws {
        isLoading = true
        
        self.tokens -= 0.3
        
        let randomID = Int.random(in: 1...151)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
        let urlString2 = "https://pokeapi.co/api/v2/pokemon-species/\(randomID)"

        guard let url = URL(string: urlString) else {
            return
        }
        guard let url2 = URL(string: urlString2) else {
            return
        }
        

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
            let (data2, _) = try await URLSession.shared.data(from: url2)
            let decoded2 = try JSONDecoder().decode(PokemonSpecies.self, from: data2)
            DispatchQueue.main.async {
                self.species = decoded2
                //print(self.species?.capture_rate ?? "420")
                self.pokemon = decoded
                self.pokemon?.name = self.formatName(self.pokemon?.name ?? "")
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
    
    func keepCard() {
        
    }
    
    func discardCard() {
        let cost = (1.0/Double((species?.capture_rate ?? 420))) * 50.0
        print(cost)
        self.tokens += cost
        print(tokens)
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
