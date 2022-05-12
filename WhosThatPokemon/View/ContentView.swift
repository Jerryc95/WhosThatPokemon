//
//  ContentView.swift
//  WhosThatPokemon
//
//  Created by Jerry Cox on 5/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network
    @Environment(\.presentationMode) var mode
    @Environment(\.scenePhase) var scenePhase
    
    @State private var pokeAnswer = ""
    @State private var score: Float = 0
    @State private var total: Float = 0
    @State private var round: Float = 1
    @State private var timeRemaining = 15
    @State private var pokeChoices: [Result] = []
    @State private var selectedAnswer: [String] = []
    @State private var correctAnswer: [String] = []
    @State private var choiceTapped = false
    @State private var isActive = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var rows = [GridItem(.flexible(minimum: 10, maximum: 75)),GridItem(.flexible(minimum: 10, maximum: 75))]

    
    var body: some View {
        ZStack {
            Image("blueSpiral")
                .ignoresSafeArea()
            if pokeAnswer == "" {
                VStack {
                    VStack(alignment: .center) {
                        Text("How to play:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.top, 5)
                            .padding(.trailing, 15)
                            .padding(.leading, 15)
                            .padding(.bottom, 5)
                        Text("Try and guess which Pokemon's silhouette is being shown and prove your knowledge and if you really are the very best. Don't go fast though, you only have one chance! How high of a score can you get?")
                            .fontWeight(.bold)
                            .padding(.trailing, 15)
                            .padding(.leading, 15)
                            .padding(.bottom, 15)
                            .multilineTextAlignment(.center)
                    }
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.black)
                            .opacity(0.3)
                    )
                    Button(action: {
                        randomPokemonGame()
                    }, label: {
                        Text("Start!")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .background(
                                Capsule()
                                    .frame(width: 120, height: 50)
                                    .foregroundColor(.electric)
                            )
                    })
                }
            } else if round < 11 {
                VStack {
                    ProgressView(value: Float(timeRemaining), total: 15)
                        .tint(countdownColor())
                        .frame(width: 250)
                        .scaleEffect(x: 1, y: 4)
                        .padding()
                    HStack(alignment: .top) {
                        Text("Round: ")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("\(Int(round))")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.ghost)
                    }
                    .padding()
                    .background(
                        Capsule()
                            .foregroundColor(.electric)
                    )
                    HStack {
                        Text("Your score is:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("\(Int(score))")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.water)
                    }
                    .padding()
                    
                    .background(
                        Capsule()
                            .foregroundColor(.electric)
                    )
                    .padding(.bottom, 75)

                    ZStack {
                        if choiceTapped == false && timeRemaining > 0 {
                            Rectangle()
                                .frame(width: 250, height: 250)
                                .foregroundColor(.black)
                                .opacity(1.0)
                                .mask {
                                    AsyncImage(url: URL(string: network.details.sprites.other.officialArtwork.frontDefault)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 250, height: 250)

                                    } placeholder: {
                                        Color.gray.opacity(0.0)
                                            .frame(width: 250, height: 250)
                                    }
                                }
                        } else if choiceTapped == true || timeRemaining == 0 {
                            AsyncImage(url: URL(string: network.details.sprites.other.officialArtwork.frontDefault)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 250, height: 250)

                            } placeholder: {
                                Color.gray.opacity(0.0)
                                    .frame(width: 250, height: 250)
                            }
                        }
                    }
                    LazyHGrid(rows: rows, alignment: .center, spacing: 75) {
                        ForEach(pokeChoices, id: \.self) { choice in
                            Button(action: {
                                optionTapped(choice)
                            }, label: {
                                if choice.name == pokeAnswer {
                                    Capsule()
                                        .frame(width: 150, height: 50)
                                        .foregroundColor(choiceTapped ? .grass : .white)
                                        .overlay(
                                            Text(choice.name.fixSuffix(choice.name).capitalizingFirstLetter())
                                        )
                                        .foregroundColor(choiceTapped ? .white : .black)
                                } else if choice.name != pokeAnswer {
                                    Capsule()
                                        .frame(width: 150, height: 50)
                                        .foregroundColor(choiceTapped ? .fire : .white)
                                        .overlay(
                                            Text(choice.name.fixSuffix(choice.name).capitalizingFirstLetter())
                                        )
                                        .foregroundColor(choiceTapped ? .white : .black)
                                }
                            })
                        }
                    }
                    Button(action: {
                        round += 1
                        choiceTapped = false
                        timeRemaining = 15
                        randomPokemonGame()
                        
                    }, label: {
                        Capsule()
                            .frame(width: 150, height: 50)
                            .foregroundColor(.dragon)
                            .overlay(
                                Text("Next")
                            )
                            .foregroundColor(.white)
                    })
                    .opacity(choiceTapped ? 1.0 : 0.0)
                    .padding()
                    .padding(.bottom, 50)
                }
                .onReceive(timer) { time in
                    guard isActive else { return }
                    if timeRemaining >= 0 && choiceTapped == false {
                        timeRemaining -= 1
                        timedOut()
                    }
                }
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        isActive = true
                    } else {
                        isActive = false
                    }
                }
            } else if round == 11 {
                VStack {
                    HStack {
                        Text("Your score is:")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("\(Int(score))")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.water)
                    }
                    .padding()
                    .background(
                        Capsule()
                            .foregroundColor(.electric)
                    )
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 250, height: 300)
                            .foregroundColor(.electric)
                        VStack {
                            Text("You Scored:")
                                .fontWeight(.bold)
                            Text("\(finalScore())%")
                                .fontWeight(.bold)
                                .padding(.bottom)
                            ForEach(Array(selectedAnswer.enumerated()), id: \.offset) { index, answer in
                                Text("#\(index + 1): \(answer)")
                                    .fontWeight(.bold)
                                    .foregroundColor(answerColor(answer))
                            }
                        }
                        .foregroundColor(.white)
                    }
                    Button(action: {
                        round = 1
                        score = 0
                        total = 0
                        choiceTapped = false
                        correctAnswer = []
                        selectedAnswer = []
                        randomPokemonGame()
                    }, label: {
                        Capsule()
                            .frame(width: 150, height: 50)
                            .foregroundColor(.dragon)
                            .overlay(
                                Text("Play again!")
                                    .fontWeight(.bold)
                            )
                            .foregroundColor(.white)
                    })
                }
            }
        }
        .onAppear {
            network.fetchResults()
        }
        //.navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    mode.wrappedValue.dismiss()
//                    pokeAnswer = ""
//                }, label: {
//                    Image(systemName: "arrow.left.circle.fill")
//                        .foregroundColor(.white)
//                })
//            }
//        }
        
    }
    
    func randomPokemonGame() {
        let allPokemon = network.results.results
        let answer = allPokemon.randomElement()
        var allchoices = allPokemon.filter { $0 != answer }
        var choices: [Result] = []
        while choices.count < 3 {
            let randomPokemon = allchoices.randomElement()
            if let usedIndex = allchoices.firstIndex(where: { $0 == randomPokemon }) {
                allchoices.remove(at: usedIndex)
            }
            choices.append(randomPokemon!)
        }
        choices.append(answer!)
        choices.shuffle()
        network.fetchDetails(url: answer!)
        pokeAnswer = answer!.name
        pokeChoices = choices
    }
    
    func optionTapped(_ choice: Result) {
        if total < round {
            if choice.name == pokeAnswer {
                correctAnswer.append(pokeAnswer)
                selectedAnswer.append(choice.name)
                choiceTapped = true
                total += 1
                score += 1
                
            } else {
                correctAnswer.append(pokeAnswer)
                selectedAnswer.append(choice.name)
                choiceTapped = true
                total += 1
            }
        }
    }
    
    func finalScore() -> Int {
        if score == total {
            return 100
        } else {
            return Int((score / total) * 100)
        }
    }
    func answerColor(_ answer: String) -> Color {
        if correctAnswer.contains(answer) {
                return .grass
            } else {
                return .fire
            }
    }
    
    func countdownColor() -> Color {
        if timeRemaining > 10 {
            return .grass
        } else if timeRemaining > 5 && timeRemaining <= 10 {
            return .electric
        } else {
            return .fire
        }
    }
    
   func timedOut() {
       if timeRemaining == 0 {
        total += 1
        choiceTapped = true
        selectedAnswer.append("Timed out")
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
