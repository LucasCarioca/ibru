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
    @State var selected: Int? = 0
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink("Brews", destination: Brews(), tag: 0, selection: $selected)
                    NavigationLink("ABV Calculator", destination: ABVCalculator(), tag: 1, selection: $selected)
//                    NavigationLink("Guides", destination: Text("Coming soon"), tag: 2, selection: $selected)
//                    NavigationLink("About", destination: Text("Coming soon"), tag: 3, selection: $selected)
//                    NavigationLink("Support", destination: Text("Coming soon"), tag: 3, selection: $selected)
                }.navigationTitle("Menu")
                Brews()
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
