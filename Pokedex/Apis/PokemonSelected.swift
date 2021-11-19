//
//  PokemonSelected.swift
//  Pokedex
//
//  Created by Federico on 19/11/2021.
//

import Foundation

struct PokemonSelected : Codable {
    var sprites: PokemonSprites
    var weight: Int
}

struct PokemonSprites : Codable {
    var front_default: String?
}


class PokemonSelectedApi  {
    func getSprite(url: String,completion:@escaping (PokemonSprites) -> ()) {
        guard let url = URL(string: url) else { return }
                
                URLSession.shared.dataTask(with: url) { (data, _, _) in
                    guard let data = data else { return }
                    
                    let pokemonSprite = try! JSONDecoder().decode(PokemonSelected.self, from: data)

                    DispatchQueue.main.async {
                        completion(pokemonSprite.sprites)
                    }
                }.resume()
    }
}
