//
//  Detail.swift
//  Pokedex
//
//  Created by Vinicius Paldês on 23/01/24.
//

import SwiftUI

struct Detail: View {
    var pokemon: Pokemon
    var body: some View {
        VStack {
                   if let imageUrl = URL(string: pokemon.imageUrl) {
                       AsyncImage(url: imageUrl) { phase in
                           switch phase {
                           case .success(let image):
                               image.resizable()
                                    .scaledToFit()
                           case .failure(_):
                               Image(systemName: "photo") // Fallback image
                           case .empty:
                               ProgressView() // Loading indicator
                           @unknown default:
                               EmptyView()
                           }
                       }
                       .frame(width: 200, height: 200)
                       .cornerRadius(10)
                       .shadow(radius: 5)
                   }

                   Text(pokemon.name)
                       .font(.title)
                       .padding()
               }
               .navigationTitle(pokemon.name)
               .navigationBarTitleDisplayMode(.inline)
               .padding()
    }
}

#Preview {
    Detail(pokemon: Pokemon(id: 1, name: "Bulbassauro", imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
