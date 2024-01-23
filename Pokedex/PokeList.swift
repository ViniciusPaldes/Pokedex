//
//  PokeList.swift
//  Pokedex
//
//  Created by Vinicius Paldês on 23/01/24.
//

import SwiftUI

struct PokeList: View {
    
    @ObservedObject var viewModel = PokemonViewModel()

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Pokedex")
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.pokemons) { pokemon in
                        NavigationLink(destination: Detail(pokemon: pokemon)) {
                            VStack {
                                if let imageUrl = URL(string: pokemon.imageUrl) {
                                    AsyncImage(url: imageUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Color.gray // Placeholder for loading or failed image
                                    }
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .padding(0)
                                }
                                Text(pokemon.name)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.bottom, 16)
                            }
                            .frame(width: .infinity, height: 120) // Adjust the size as needed
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                }

            }.onAppear {
                viewModel.fetchPokemons()
            }
        }
        
    }
}

#Preview {
    PokeList()
}
