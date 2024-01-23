//
//  Pokemon.swift
//  Pokedex
//
//  Created by Vinicius Paldês on 23/01/24.
//

import Foundation

struct Pokemon: Identifiable {
    var id: Int
    var name: String
    var imageUrl: String
    var url: String
}

struct PokemonListResponse: Codable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
}

struct PokemonDetail: Codable {
    let id: Int
    let sprites: PokemonSprites
}

struct PokemonSprites: Codable {
    let front_default: String
}
