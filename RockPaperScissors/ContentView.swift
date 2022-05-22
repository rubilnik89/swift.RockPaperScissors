//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Roman Zherebko on 22.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var score = 0
    @State private var round = 0
    @State private var alertText = ""
    @State private var alertIsShown = false
    @State private var alertIsShownFinished = false
    @State private var caseOption = Bool.random()
    @State private var imageOption = Int.random(in: 0...2)
    @State private var gameOptions = ["Paper", "Rock", "Scissors"].shuffled()
    @State private var randomColor = Color.random
    
    let winOptions = ["Paper": "Rock", "Rock": "Scissors", "Scissors": "Paper"]
    let loseOptions = ["Paper": "Scissors", "Rock": "Paper", "Scissors": "Rock"]
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Try to")
                .font(.largeTitle.bold())
                Text(caseOption ? "WIN" : "LOSE")
                    .font(.largeTitle.bold())
                    .foregroundColor(randomColor)
            }
            
            Image(gameOptions[imageOption])
                .resizable()
                .frame(width: 200, height: 200)
            
            Spacer()
            
            HStack {
                ForEach(gameOptions, id: \.self) { option in
                    Button {
                        answer(choice: option)
                    } label: {
                        Image(option)
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
            }
            
            Spacer()
            
            Text("Score: \(score)")
                .font(.title.bold())
                .foregroundColor(.mint)
            
            Spacer()
            
            Text("Current round: \(round)")
                .font(.title3)
        }
        .alert(alertText, isPresented: $alertIsShown) {
            Button("Next round") { }
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game finished", isPresented: $alertIsShownFinished) {
            Button("Try again") {
                round = 0
                score = 0
            }
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func answer(choice: String) {
        if caseOption {
            if winOptions[choice]! == gameOptions[imageOption] {
                correct()
            } else if choice == gameOptions[imageOption] {
                same()
            } else {
                wrong()
            }
        } else {
            if gameOptions[imageOption] == loseOptions[choice] {
                correct()
            } else if choice == gameOptions[imageOption] {
                same()
            } else {
                wrong()
            }
        }
        
        caseOption = Bool.random()
        imageOption = Int.random(in: 0...2)
        gameOptions = gameOptions.shuffled()
        randomColor = Color.random
        
        if round < 8 {
            round += 1
            alertIsShown = true
        } else {
            alertIsShownFinished = true
        }
    }
    
    func correct() {
        alertText = "Correctly"
        score += 1
    }
    
    func wrong() {
        alertText = "Sorry, it's wrong"
        score -= 1
    }
    
    func same() {
        alertText = "You can do better"
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
