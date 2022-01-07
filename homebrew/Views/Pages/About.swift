//
// Created by Lucas Desouza on 1/7/22.
//

import SwiftUI
import CoreData
import QuickComponents

struct About: View {

    @State var version = ""
    @State var build = ""
    @State var count = 0
    @State var lastVersionPrompted = ""

    var body: some View {
        List {
            #if DEBUG
            NavigationLink(destination: DevTools()) {
                Label("Dev Tools", systemImage: "chevron.left.slash.chevron.right")
            }
            HStack {
                Text("Current count")
                Spacer()
                Text(String(count))
            }
            HStack {
                Text("Last version prompted")
                Spacer()
                Text("v\(lastVersionPrompted)")
            }
            #endif
            HStack {
                Text("Current version")
                Spacer()
                Text("v\(version) (\(build))")
            }
        }
                .navigationBarTitle("About")
                .onAppear(perform: {
                    (version, build) = getVersion()
                    (count, lastVersionPrompted) = getSessionCount()
                })
    }
}
