//
//  Pokemon.swift
//  Pokedex
//
//  Created by Federico on 19/11/2021.
//

import Foundation

struct Pokemon : Codable{
    var results: [PokemonEntry]
    
}

struct PokemonEntry : Codable, Identifiable  {
    let id = UUID()
    var name: String
    var url: String
}

class PokeApi  {
    func getData(completion:@escaping ([PokemonEntry]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
                
                URLSession.shared.dataTask(with: url) { (data, _, _) in
                    guard let data = data else { return }
                    
                    let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)

                    DispatchQueue.main.async {
                        completion(pokemonList.results)
                    }
                }.resume()
    }
}
