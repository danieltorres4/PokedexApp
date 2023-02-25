//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Iván Sánchez Torres on 24/02/23.
//

import Foundation


struct PokemonDetail: Codable {
    var sprites: Sprite
    var weight: Int
    var height: Int
    var id: Int
    var name: String
}

struct Sprite: Codable {
    var front_default: String?
    var front_shiny: String?
}

struct PokemonBasicInfo {
    var sprites: Sprite
    var weight: Int
    var height: Int
    var id: Int
    var name: String
    
    static var empty: Self {
        .init(sprites: Sprite(front_default: "", front_shiny: ""), weight: 0, height: 0, id: 0, name: "")
    }
}
