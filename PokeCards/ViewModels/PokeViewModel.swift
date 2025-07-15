//
//  PokeViewModel.swift
//  PokeCards
//
//  Created by Nathaniel Bedggood on 15/07/2025.
//

import Foundation
import Combine

class PokeViewModel: ObservableObject {
    
    @Published var pokemon: Pokemon?
    
    func retrieveRandomPokemon() {
        
    }
    
    func fetchDitto() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/ditto") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        self.pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    } catch {
                        print("Decode error: \(error)")
                    }
                }
            }.resume()
    }
    
}
