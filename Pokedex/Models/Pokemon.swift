//
//  Pokemon.swift
//  Pokedex
//
//  Created by Iván Sánchez Torres on 23/02/23.
//

import Foundation

struct PokemonResponseDataModel: Decodable {
    let pokemons: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pokemons = try container.decode([Pokemon].self, forKey: .results)
    }
}

struct Pokemon: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
}
