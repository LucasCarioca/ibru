//
//  Settings.swift
//  iBru
//
//  Created by Lucas Desouza on 9/19/21.
//

import SwiftUI

struct Settings: View {

    @StateObject var storeManager: StoreManager

    var body: some View {
        List {
            Section(header: Text("App Settings")) {
                Label("Account Status: \(getUserType()) User", systemImage: "person")
                if !UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                    NavigationLink(destination: ProFeatures(storeManager: storeManager)) {
                        Label("Upgrade to Pro", systemImage: "star")
                    }
                }
            }


            #if DEBUG
            Spacer()
            Section(header: Text("Hidden Settings")) {
                NavigationLink(destination: DevTools()) {
                    Label("Dev Tools", systemImage: "chevron.left.slash.chevron.right")
                }
            }
            #endif
        }.navigationTitle("Settings")
    }

    func getUserType() -> String {
        if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
            return "Pro"
        }
        return "Free"
    }
}
