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
    let dataSource: Datasource
    @StateObject var storeManager = StoreManager()

    init() {
        if CommandLine.arguments.contains("-test-data") {
            UserDefaults.standard.register(defaults: [
                "0001": true
            ])
            dataSource = Datasource(inMemory: true)
        } else {
            dataSource = Datasource(inMemory: false)
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    Section {
                        if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                            NavigationLink(destination: Dashboard()) {
                                Label("Dashboard", systemImage: "chart.bar")
                            }
                            NavigationLink(destination: Collection()) {
                                Label("Collection", systemImage: "square.grid.3x2")
                            }
                        } else {
                            NavigationLink(destination: ProFeatures(storeManager: storeManager)) {
                                Label("Dashboard", systemImage: "lock.fill")
                            }
                            NavigationLink(destination: ProFeatures(storeManager: storeManager)) {
                                Label("Collection", systemImage: "lock.fill")
                            }
                        }
                        NavigationLink(destination: Brews()) {
                            Label("Brew List", systemImage: "list.bullet.rectangle")
                        }
                    }
                    Section {
                        NavigationLink(destination: Calculators()) {
                            Label("Calculators", systemImage: "function")
                        }
                    }
                    if !UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                        Section {
                            NavigationLink(destination: ProFeatures(storeManager: storeManager)) {
                                Label("Upgrade to Pro", systemImage: "star.fill")
                            }
                        }
                    }
                    #if DEBUG
                    Section {
                        NavigationLink(destination: DevTools()) {
                            Label("Dev Tools", systemImage: "chevron.left.slash.chevron.right")
                        }
                    }
                    #endif
                }.navigationTitle("Menu")
                if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                    Dashboard()
                } else {
                    Brews()
                }
            }
                    .environment(\.managedObjectContext, dataSource.getContainer().viewContext)
                    .environmentObject(storeManager)
                    .onAppear(perform: {
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            requestReview(in: scene)
                        } else {
                            print("no scene found")
                        }
                        SKPaymentQueue.default().add(storeManager)
                        storeManager.getProducts(productIDs: ["0001"])
                    })
        }
    }
}
