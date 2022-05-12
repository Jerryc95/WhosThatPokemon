//
//  String-Extensions.swift
//  WhosThatPokemon
//
//  Created by Jerry Cox on 5/11/22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func fixSuffix(_ text: String) -> String {
        if text.hasSuffix("-m") {
            let newText = text.replacingOccurrences(of: "-m", with: "♂")
            return newText
        } else if text.hasSuffix("-f") {
            let newText = text.replacingOccurrences(of: "-f", with: "♀")
            return newText
        } else if text.hasSuffix("-jr") {
            let newText = text.replacingOccurrences(of: "-jr", with: " jr")
            return newText
        } else if text.hasSuffix("-altered") {
            let newText = text.replacingOccurrences(of: "-altered", with: "")
            return newText
        } else if text.hasSuffix("-land") {
            let newText = text.replacingOccurrences(of: "-land", with: "")
            return newText
        } else if text.hasSuffix("-standard") {
            let newText = text.replacingOccurrences(of: "-standard", with: "")
            return newText
        } else if text.hasSuffix("-incarnate") {
            let newText = text.replacingOccurrences(of: "-incarnate", with: "")
            return newText
        } else if text.hasSuffix("-average") {
            let newText = text.replacingOccurrences(of: "-average", with: "")
            return newText
        } else if text.hasSuffix("-striped") {
            let newText = text.replacingOccurrences(of: "-striped", with: "")
            return newText
        } else if text.hasSuffix("-land") {
            let newText = text.replacingOccurrences(of: "-land", with: "")
            return newText
        } else if text.hasSuffix("-50") {
            let newText = text.replacingOccurrences(of: "-50", with: "")
            return newText
        } else if text.hasSuffix("-male") {
            let newText = text.replacingOccurrences(of: "-male", with: "")
            return newText
        } else if text.hasSuffix("-aria") {
            let newText = text.replacingOccurrences(of: "-aria", with: "")
            return newText
        } else if text.hasSuffix("-shield") {
            let newText = text.replacingOccurrences(of: "-shield", with: "")
            return newText
        } else if text.hasSuffix("-ordinary") {
            let newText = text.replacingOccurrences(of: "-ordinary", with: "")
            return newText
        } else if text.hasSuffix("-normal") {
            let newText = text.replacingOccurrences(of: "-normal", with: "")
            return newText
        } else if text.hasSuffix("-plant") {
            let newText = text.replacingOccurrences(of: "-plant", with: "")
            return newText
        } else if text.hasSuffix("-red") {
            let newText = text.replacingOccurrences(of: "-red", with: "")
            return newText
        }
        return text
    }
    
    func adjustStats(_ text: String) -> String {
        if text == "attack" {
            let newText = text.replacingOccurrences(of: "attack", with: "ATK  ")
            return newText
        } else if text == "defense" {
            let newText = text.replacingOccurrences(of: "defense", with: "DEF  ")
            return newText
        } else if text == "speed" {
            let newText = text.replacingOccurrences(of: "speed", with: "SPD  ")
            return newText
        } else if text == "special-attack" {
            let newText = text.replacingOccurrences(of: "special-attack", with: "SATK")
            return newText
        } else if text == "special-defense" {
            let newText = text.replacingOccurrences(of: "special-defense", with: "SDEF")
            return newText
        } else if text == "hp" {
            let newText = text.replacingOccurrences(of: "hp", with: "HP   ")
            return newText
        }
        return text
    }
    
    func removeDash(_ text: String) -> String {
        if text.contains("-") {
            let newText = text.replacingOccurrences(of: "-", with: " ")
            return newText
        }
        return text
    }
    
    func removeN(_ text: String) -> String {
        if text.contains("\n ") {
            let newText = text.replacingOccurrences(of: "\n ", with: " ")
            return newText
        } else if text.contains("\n") {
            let newText = text.replacingOccurrences(of: "\n", with: "")
            return newText
        } else if text.contains(" \n") {
            let newText = text.replacingOccurrences(of: " \n", with: " ")
            return newText
        }
        return text
    }
    
    func urlIndex(url: String) -> String {
        var index = url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "")
        index.removeLast()
        return index
    }
    
    func speciesURL(url: String) -> String {
        var index = url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "")
        index.removeLast()
        return index
    }
}
