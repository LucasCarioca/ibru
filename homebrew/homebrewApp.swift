//
//  homebrewApp.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI
import StoreKit

@main
struct homebrewApp: App {
    let persistenceController: PersistenceController
    @StateObject var storeManager = StoreManager()
    @State var selected: Int? = 2
    init() {
        if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
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
                    if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                        NavigationLink(destination: Dashboard(), tag: 0, selection: $selected){
                            Label("Dashboard", systemImage: "chart.bar")
                        }
                    }
                    if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                        NavigationLink(destination: Collection(), tag: 1, selection: $selected){
                            Label("Collection", systemImage: "square.grid.3x2")
                        }
                    }
                    NavigationLink(destination: Brews(), tag: 2, selection: $selected){
                        Label("Brew List", systemImage: "list.bullet.rectangle")
                    }
                    NavigationLink(destination: Calculators(), tag: 3, selection: $selected){
                        Label("Calculators", systemImage: "function")
                    }
                    if !UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                        NavigationLink(destination: ProFeatures(storeManager: storeManager), tag: 4, selection: $selected){
                            Label("Upgrade to Pro", systemImage: "star")
                        }
                    }
                    #if DEBUG
                    NavigationLink(destination: DevTools(), tag: 5, selection: $selected){
                        Label("Dev Tools", systemImage: "chevron.left.slash.chevron.right")
                    }
                    #endif
                    UserDefaults.standard.bool(forKey: StoreManager.productKey) ? Text("iBru Pro User") : nil
                    
                }.navigationTitle("Menu")
                Dashboard()
            }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .onAppear(perform: {
                SKPaymentQueue.default().add(storeManager)
                storeManager.getProducts(productIDs: ["0001"])
            })
        }
    }
}
