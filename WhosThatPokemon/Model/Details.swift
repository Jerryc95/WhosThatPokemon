//
//  Details.swift
//  WhosThatPokemon
//
//  Created by Jerry Cox on 5/11/22.
//

import Foundation

struct Details: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let sprites: Sprites

    enum codingKeys: String, CodingKey {
        case locationAreaEncounters = "location_area_encounters"
    }
    
    static let example = Details(
        id: 1,
        name: "Bulbasaur",
        sprites: Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", other: Other(officialArtwork: OfficialArtwork(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")))
    )
}

class Sprites: Decodable, Hashable {
    static func == (lhs: Sprites, rhs: Sprites) -> Bool {
        lhs.frontDefault == rhs.frontDefault && lhs.other == rhs.other
    }
    
    let frontDefault: String
    let other: Other

    init(frontDefault: String, other: Other) {
        self.frontDefault = frontDefault
        self.other = other
            
        }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(frontDefault)
    }
}

struct Other: Decodable, Hashable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Decodable, Hashable {
    let frontDefault: String
}
