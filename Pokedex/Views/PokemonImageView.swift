//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Iván Sánchez Torres on 24/02/23.
//

import SwiftUI

struct PokemonImageView: View {
    var imageLink = ""
    @State private var pokemonSprite = ""
    @State private var pokemonShinySprite = ""
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 100, height: 100)
            .onAppear {
                let loadedData = UserDefaults.standard.string(forKey: imageLink)
                
                if loadedData == nil {
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                } else {
                    getSprite(url: loadedData!)
                }
            }
            .clipShape(Circle())
            .foregroundColor(.purple.opacity(0.99))
    }
    
    func getSprite(url: String) {
        var tempSprite: String = ""
        var tempShinySprite: String = ""
        
        Task {
            await viewModel.getPokemonSprites(url: url, completion: { sprite in
                tempSprite = sprite.front_default ?? "placeholder"
                tempShinySprite = sprite.front_shiny ?? "placeholder"
                
                self.pokemonSprite = tempSprite
                self.pokemonShinySprite = tempShinySprite
            })
        }
    }
}

struct PokemonImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView()
    }
}
