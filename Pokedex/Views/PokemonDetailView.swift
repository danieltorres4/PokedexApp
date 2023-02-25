//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Iván Sánchez Torres on 24/02/23.
//

import SwiftUI

struct PokemonDetailView: View {
    var detailsLink = ""
    @State var pokemonDetails = ""
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        VStack {
            HStack {
                
                if viewModel.pokemonBasicInfo.sprites.front_default != nil {
                    AsyncImage(url: URL(string: viewModel.pokemonBasicInfo.sprites.front_default ?? "star.fill")) { image in
                        image.resizable().scaledToFit().cornerRadius(20)
                    } placeholder: {
                        ProgressView()
                    }.padding()
                    
                } else {
                    Image(systemName: "questionmark.circle.fill")
                }
                

                if viewModel.pokemonBasicInfo.sprites.front_shiny != nil {
                    AsyncImage(url: URL(string: viewModel.pokemonBasicInfo.sprites.front_shiny ?? "star.fill")) { image in
                        image.resizable().scaledToFit().cornerRadius(20)
                    } placeholder: {
                        ProgressView()
                    }.padding()
                } else {
                    Image(systemName: "questionmark.circle.fill")
                }
                
            }
            
            Text("Pokedex ID: \(viewModel.pokemonBasicInfo.id)").font(.caption).padding()
            Text("\(viewModel.pokemonBasicInfo.name)").font(.title).bold().padding()
            Text("Height: \(viewModel.pokemonBasicInfo.height)").font(.headline).padding()
            Text("Weight: \(viewModel.pokemonBasicInfo.weight)").font(.headline).padding()
                
        }
        .onAppear {
            let loadedData = UserDefaults.standard.string(forKey: detailsLink)
            
            if loadedData == nil {
                getDetails(url: detailsLink)
                UserDefaults.standard.set(detailsLink, forKey: detailsLink)
            } else {
                getDetails(url: loadedData!)
            }
        }
        
    }
    
    func getDetails(url: String) {
        var tempName: String = ""
        var tempWeight: Int = 0
        var tempHeight: Int = 0
        var tempID: Int = 0
        var tempSpriteDefault: String = ""
        var tempSpriteShiny: String = ""
        
        Task {
            await viewModel.getPokemonDetail2(url: url, completion: { detail in
                tempName = detail.name
                tempWeight = detail.weight
                tempHeight = detail.height
                tempID = detail.id
                tempSpriteDefault = detail.sprites.front_default ?? "placeholder"
                tempSpriteShiny = detail.sprites.front_shiny ?? "placeholder"
                
                self.viewModel.pokemonBasicInfo.name = tempName
                self.viewModel.pokemonBasicInfo.weight = tempWeight
                self.viewModel.pokemonBasicInfo.height = tempHeight
                self.viewModel.pokemonBasicInfo.id = tempID
                self.viewModel.pokemonBasicInfo.sprites.front_default = tempSpriteDefault
                self.viewModel.pokemonBasicInfo.sprites.front_shiny = tempSpriteShiny
            })
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView()
    }
}
