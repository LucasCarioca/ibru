//
//  homebrewApp.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

@main
struct homebrewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                Brews()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
