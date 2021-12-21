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
            
        }.navigationTitle("Settings")
    }

    func getUserType() -> String {
        if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
            return "Pro"
        }
        return "Free"
    }
}
