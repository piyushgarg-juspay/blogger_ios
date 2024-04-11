//
//  bloggerApp.swift
//  blogger
//
//  Created by piyush garg on 21/12/23.
//

import SwiftUI
import SwiftData

@main
struct bloggerApp: App {
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

//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .modelContainer(sharedModelContainer)
//    }
    
    var body: some Scene {
        WindowGroup {
            WebView_UI()
        }
    }
}
