//
//  Results.swift
//  WhosThatPokemon
//
//  Created by Jerry Cox on 5/11/22.
//

import Foundation

struct Results: Hashable, Decodable {
    var results: [Result]
    
    static let example = Results(results: [
    
    ])
}

struct Result: Hashable, Decodable {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    static let example = Result(name: "Bulbasuar", url: "https://pokeapi.co/api/v2/pokemon/1/")
}
