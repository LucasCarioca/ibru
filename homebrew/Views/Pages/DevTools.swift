//
//  DevTools.swift
//  iBru
//
//  Created by Lucas Desouza on 9/17/21.
//

import SwiftUI

struct DevTools: View {
    @EnvironmentObject var proStatusControl: ProStatusControl
    var body: some View {
        List {
            Button(action: toggleProFeatures) {
                Text("Toggle Pro Features")
            }
        }.navigationTitle("Upgrade to Pro")
    }
    
    func toggleProFeatures() {
        if proStatusControl.isPro {
            ProStatusControl.notPurchased()
        } else {
            ProStatusControl.purchased()
        }
    }
}

struct DevTools_Previews: PreviewProvider {
    static var previews: some View {
        DevTools()
    }
}
