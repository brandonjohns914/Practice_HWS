//
//  GameWithLogicRemovedToNewFile.swift
//  WordScramble
//
//  Created by Brandon Johns on 3/20/24.
//

import SwiftUI

struct GameWithLogicRemovedToNewFile: View {
    @EnvironmentObject var wordScramble: WordScramble
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Score \(wordScramble.score)")
                }
                
                Section{
                    TextField("Enter your word", text: $wordScramble.newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section("Accepted Words") {
                    ForEach(wordScramble.usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(wordScramble.rootWord)
            .toolbar {
                Button("New Game", action: wordScramble.newGame)
            }
            .onSubmit(wordScramble.addNewWord)
            .onAppear(perform: wordScramble.startGame)
            .alert(wordScramble.errorTitle, isPresented: $wordScramble.showingError) { } message : {
                Text(wordScramble.errorMessage)
            }
        }
    }
}

#Preview {
    GameWithLogicRemovedToNewFile()
}
