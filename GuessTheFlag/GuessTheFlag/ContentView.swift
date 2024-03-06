//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brandon Johns on 3/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfQuestions = 1
    @State private var showingResult = false
    
    
   @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
   @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack(spacing: 5) {
                    Text("Tap the flag of")
                        .font(.title2.weight(.heavy))
                        .foregroundStyle(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.white)
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.headline)
                    Text("Question \(numberOfQuestions)")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                }
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .resizable()
                            .scaledToFit()
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your Score is \(score)")
        }
        .alert("Game Over", isPresented: $showingResult){
            Button("New Game", action: newGame)
        } message: {
            Text("Your Score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int){
        if numberOfQuestions <= 8 {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
            } else {
                if countries[number] == "US" || countries[number] == "UK" {
                    scoreTitle = "Wrong, thats the \(countries[number]) flag"
                } else {
                    scoreTitle = "Wrong, thats \(countries[number]) flag"
                    score -= 1
                }
            }
            showingScore = true
        }
        if numberOfQuestions == 8 {
            showingResult = true
        }
      
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        numberOfQuestions += 1
    }
    
    func newGame() {
        numberOfQuestions = 0
        score = 0
        askQuestion()
    }
    
   
}

#Preview {
    ContentView()
}
