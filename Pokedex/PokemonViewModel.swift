//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Vinicius Paldês on 23/01/24.
//
import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    private let baseUrl = "https://pokeapi.co/api/v2/pokemon"

    func fetchPokemons() {
        guard let url = URL(string: baseUrl) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }

            if let pokemonListResponse = try? JSONDecoder().decode(PokemonListResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.pokemons = pokemonListResponse.results.prefix(20).map { Pokemon(id: 0, name: $0.name, imageUrl: "", url: $0.url) }
                    print (self.pokemons)
                    self.fetchDetailsForPokemons()
                }
            }
        }.resume()
    }

    private func fetchDetailsForPokemons() {
        for (index, pokemon) in pokemons.enumerated() {
            guard let detailUrl = URL(string: pokemon.url) else { continue }

            URLSession.shared.dataTask(with: detailUrl) { (data, _, _) in
                guard let data = data else { return }

                if let pokemonDetail = try? JSONDecoder().decode(PokemonDetail.self, from: data) {
                    DispatchQueue.main.async {
                        self.pokemons[index] = Pokemon(id: pokemonDetail.id, name: pokemon.name, imageUrl: pokemonDetail.sprites.front_default, url: pokemon.url)
                    }
                }
            }.resume()
        }
    }
}
