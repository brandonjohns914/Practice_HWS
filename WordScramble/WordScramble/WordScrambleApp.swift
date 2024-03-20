//
//  WordScrambleApp.swift
//  WordScramble
//
//  Created by Brandon Johns on 3/6/24.
//

import SwiftUI

@main
struct WordScrambleApp: App {
    @StateObject var wordScramble = WordScramble()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(wordScramble)
    }
}
