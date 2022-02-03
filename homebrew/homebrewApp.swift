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
    @AppStorage(StoreManager.productKey) var pro: Bool = false
    @StateObject var storeManager = StoreManager()
    @State var version = ""
    @State var build = ""
    @State var count = 0
    @State var lastVersionPrompted = ""

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
            TabView {
                if pro {
                    DashboardRoot().tabItem {
                        Label("Dash", systemImage: "chart.bar")
                    }
                    CollectionRoot().tabItem {
                        Label("Collection", systemImage: "square.grid.3x2")
                    }
                }
                Brews().tabItem {
                    Label("List", systemImage: "list.bullet.rectangle")
                }
                if !pro {
                    ProFeatures(storeManager: storeManager).tabItem {
                        Label("Pro Features", systemImage: "star.fill")
                    }
                }
                Calculators().tabItem {
                    Label("Calculators", systemImage: "function")
                }
                About().tabItem {
                    Label("About", systemImage: "info.circle.fill")
                }
            }
                    .environment(\.managedObjectContext, dataSource.getContainer().viewContext)
                    .environmentObject(storeManager)
                    .onAppear(perform: {
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            requestReview(in: scene)
                            (version, build) = getVersion()
                            (count, lastVersionPrompted) = getSessionCount()
                        }
                        SKPaymentQueue.default().add(storeManager)
                        storeManager.getProducts(productIDs: ["0001"])
                    })
        }
    }
}
