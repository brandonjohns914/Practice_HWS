//
//  WordScramble.swift
//  WordScramble
//
//  Created by Brandon Johns on 3/20/24.
//

import Foundation
import SwiftUI

class WordScramble: ObservableObject {
    
    @Published var usedWords = [String]()
    @Published var rootWord = ""
    @Published var newWord = ""
    
    @Published var errorTitle = ""
    @Published var errorMessage = ""
    @Published var showingError = false
    @Published var score = 0
    
    //func addNewWord(newWord: String)
    func addNewWord() {
        // lowercase and trim to avoid duplicate
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if empty string
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word Not Possible", message: "You cant spell that word form '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You cannot just make up words you know!")
            return
        }
        
        guard isWordLessthan3Letters(word: answer) else {
            wordError(title: "Words must contain three letters", message: "the word '\(answer)' is less than three letters ")
            return
        }
        
        
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        self.newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
        
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func isWordLessthan3Letters(word: String) -> Bool {
        if word.count <= 2{
            return false
        } else {
            return true
        }
    }
    
    
    func startGame() {
        // Find start.txt in bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // split the stings into an array with line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // pick random word or use silkworm
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
        }
        
        fatalError("Could not load start.txt")
    }
    
    func gameScore(word: String) {
        switch word.count {
        case 4:
            score += 4
            
        case 5:
            score += 5
        
        case 6:
            score += 6
            
        case 7:
            score += 7
            
        case 8:
            score += 8
        
        default:
            score += 3
        }
    }
    
    func newGame() {
        score = 0
        usedWords.removeAll()
        startGame()
    }

    
}
