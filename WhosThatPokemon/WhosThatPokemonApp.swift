//
//  WhosThatPokemonApp.swift
//  WhosThatPokemon
//
//  Created by Jerry Cox on 5/11/22.
//

import SwiftUI

@main
struct WhosThatPokemonApp: App {
    var network = Network(details: Details.example, results: Results.example)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
