//
//  PokeModel.swift
//  Pokedex
//
//  Created by Laura Vega on 11/07/23.
//

import Foundation

struct Pokeapi: Codable {
    let results: [Result]?
}

struct Result:Codable{
    let name: String?
    let url: String?
}
struct Pokemon: Codable, Equatable{
    let name: String
    let imageURL: String
}

