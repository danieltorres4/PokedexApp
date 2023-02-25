//
//  ContentView.swift
//  Pokedex
//
//  Created by Iván Sánchez Torres on 23/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    @State var pokemon = [Pokemon]()
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchText == "" ? pokemon : pokemon.filter( {  $0.name.contains(searchText.lowercased())
                    
                })) { entry in
                    HStack {
                        PokemonImageView(imageLink: "\(entry.url)")
                            .padding(.trailing, 20)
                        
                        NavigationLink("\(entry.name)".capitalized) {
                            PokemonDetailView(detailsLink: "\(entry.url)")
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.getPokemonData { pokemon in
                        self.pokemon = pokemon
                        
                        for pokemon in pokemon {
                            print(pokemon.name)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Pokedex")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
