//
//  PokeCardsApp.swift
//  PokeCards
//
//  Created by Nathaniel Bedggood on 15/07/2025.
//

import SwiftUI
import SwiftData

@main
struct PokeCardsApp: App {
    
    init() {
           UIView.appearance().overrideUserInterfaceStyle = .light
       }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
