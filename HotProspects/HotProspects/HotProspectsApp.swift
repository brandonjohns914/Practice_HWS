//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Brandon Johns on 3/28/24.
//

import SwiftUI
import SwiftData


@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
