//
//  DevTools.swift
//  iBru
//
//  Created by Lucas Desouza on 9/17/21.
//

import SwiftUI

struct DevTools: View {
    var body: some View {
        List {
            Button(action: {
                UserDefaults.standard.setValue(true, forKey: StoreManager.productKey)
            }) {
                Text("Enable Pro Features")
            }
            Button(action: {
                UserDefaults.standard.setValue(false, forKey: StoreManager.productKey)
            }) {
                Text("Reset Pro Status")
            }
        }.navigationTitle("Upgrade to Pro")
    }

}

struct DevTools_Previews: PreviewProvider {
    static var previews: some View {
        DevTools()
    }
}
