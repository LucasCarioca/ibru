//
//  homebrewApp.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

@main
struct homebrewApp: App {
    let persistenceController: PersistenceController
    @State var selected: Int? = 0
    init() {
        print("---------------------------------------------------")
        print("                  Starting App                     ")
        print("---------------------------------------------------")
        print(CommandLine.arguments.contains("-test-data"))
        print("---------------------------------------------------")
        if CommandLine.arguments.contains("-test-data") {
            persistenceController = PersistenceController.preview
        } else {
            persistenceController = PersistenceController.shared
        }
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink(destination: Dashboard(), tag: 0, selection: $selected){
                        Label("Dashboard", systemImage: "chart.bar")
                    }
                    NavigationLink(destination: Collection(), tag: 1, selection: $selected){
                        Label("Collection", systemImage: "square.grid.3x2")
                    }
                    NavigationLink(destination: Brews(), tag: 2, selection: $selected){
                        Label("Brew List", systemImage: "list.bullet.rectangle")
                    }
                    NavigationLink(destination: Calculators(), tag: 3, selection: $selected){
                        Label("Calculators", systemImage: "function")
                    }
                }.navigationTitle("Menu")
                Dashboard()
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
