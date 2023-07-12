//
//  ImageModel.swift
//  Pokedex
//
//  Created by Laura Vega on 12/07/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let imageData = try? JSONDecoder().decode(ImageData.self, from: jsonData)

import Foundation


struct ImageData: Codable {
    let sprites: Sprites
}

class Sprites: Codable {
    let other: Other?
   
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}
struct OfficialArtwork: Codable {
    let frontDefault: String
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
struct ImageModel:Codable{
    let imageURL: String
}
