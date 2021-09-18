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
            Button(action: {}) {
                Text("Toggle Pro Features")
            }
        }.navigationTitle("Upgrade to Pro")
    }
    
}

struct DevTools_Previews: PreviewProvider {
    static var previews: some View {
        DevTools()
    }
}
