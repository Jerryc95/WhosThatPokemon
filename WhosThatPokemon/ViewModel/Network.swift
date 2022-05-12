//
//  Network.swift
//  WhosThatPokemon
//
//  Created by Jerry Cox on 5/11/22.
//

import SwiftUI

class Network: ObservableObject {
    @Published var details: Details
    @Published var results: Results
    
    init(details: Details, results: Results) {
        self.details = details
        self.results = results
    }

    func fetchResults()  {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=386")!
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("request error:", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedResults = try decoder.decode(Results.self, from: data)
                        self.results = decodedResults
                    } catch let error {
                        print("error decoding:", error)
                    }
                }
            }
        }
         dataTask.resume()
    }
    
    func fetchDetails(url: Result) {
        guard let url = URL(string: url.url) else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("request error:", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedDetails = try decoder.decode(Details.self, from: data)
                        self.details = decodedDetails
                    } catch let error {
                        print("error decoding:", error)
                    }
                }
            }
        }
         dataTask.resume()
    }
}
