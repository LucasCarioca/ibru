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
                    NavigationLink(destination: Dashboard(), tag: 0, selection: $selected){
                        Label("Dashboard", systemImage: "chart.bar")
                    }
                    NavigationLink(destination: Brews(), tag: 1, selection: $selected){
                        Label("Brew List", systemImage: "list.bullet.rectangle")
                    }
                    NavigationLink(destination: Calculators(), tag: 1, selection: $selected){
                        Label("Calculators", systemImage: "function")
                    }
//                    NavigationLink("Guides", destination: Text("Coming soon"), tag: 2, selection: $selected)
//                    NavigationLink("About", destination: Text("Coming soon"), tag: 3, selection: $selected)
//                    NavigationLink("Support", destination: Text("Coming soon"), tag: 3, selection: $selected)
                }.navigationTitle("Menu")
                Brews()
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
