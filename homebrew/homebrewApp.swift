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
    let proStatusControl = ProStatusControl()
    let storeManager = StoreManager()
    @State var selected: Int? = 2
    init() {
        if proStatusControl.isPro {
            selected = 0
        }
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
                    }.modifier(ProFeatureProtect())
                    NavigationLink(destination: Collection(), tag: 1, selection: $selected){
                        Label("Collection", systemImage: "square.grid.3x2")
                    }.modifier(ProFeatureProtect())
                    NavigationLink(destination: Brews(), tag: 2, selection: $selected){
                        Label("Brew List", systemImage: "list.bullet.rectangle")
                    }
                    NavigationLink(destination: Calculators(), tag: 3, selection: $selected){
                        Label("Calculators", systemImage: "function")
                    }
                    NavigationLink(destination: ProFeatures(), tag: 4, selection: $selected){
                        Label("Upgrade to Pro", systemImage: "star")
                    }.modifier(ProHidden())
                    #if DEBUG
                    NavigationLink(destination: DevTools(), tag: 5, selection: $selected){
                        Label("Dev Tools", systemImage: "chevron.left.slash.chevron.right")
                    }
                    #endif
                }.navigationTitle("Menu")
                Dashboard()
            }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(proStatusControl)
                .environmentObject(storeManager)
        }
    }
}
