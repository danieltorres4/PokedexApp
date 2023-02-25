//
//  ViewModel.swift
//  Pokedex
//
//  Created by Iván Sánchez Torres on 23/02/23.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var pokemonBasicInfo: PokemonBasicInfo = .empty
    
    func getPokemonData(completion: @escaping (([Pokemon]) -> ())) async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0") else { return }
        
        let (data, _) = try! await URLSession.shared.data(from: url)
        let pokemonList = try! JSONDecoder().decode(PokemonResponseDataModel.self, from: data)
        
        DispatchQueue.main.async {
            completion(pokemonList.pokemons)
        }
    }
    
    func getPokemonDetail2(url: String, completion: @escaping (PokemonBasicInfo) -> ()) async {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                print("Error")
            }
            
            if let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let pokemonDetail = try! JSONDecoder().decode(PokemonDetail.self, from: data)
                
                DispatchQueue.main.async {
                    self.pokemonBasicInfo = .init(sprites: Sprite(front_default: pokemonDetail.sprites.front_default, front_shiny: pokemonDetail.sprites.front_shiny), weight: pokemonDetail.weight, height: pokemonDetail.height, id: pokemonDetail.id, name: pokemonDetail.name)
                    
                    completion(self.pokemonBasicInfo)
                }
            }
        }.resume()
    }
    
    func getPokemonSprites(url: String, completion: @escaping (Sprite) -> ()) async {
        guard let url = URL(string: url) else { return }
        
        let (data, _) = try! await URLSession.shared.data(from: url)
        let pokemonDetail = try! JSONDecoder().decode(PokemonDetail.self, from: data)
        
        DispatchQueue.main.async {
            //self.pokemonBasicInfo = .init(sprites: pokemonDetail.sprites, weight: pokemonDetail.weight, height: pokemonDetail.height, id: pokemonDetail.id, name: pokemonDetail.name)
            completion(pokemonDetail.sprites)
        }
    }
    
}
