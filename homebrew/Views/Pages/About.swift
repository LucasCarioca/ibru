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
    @State var tapVersion = 0
    @State var devMode = false

    var body: some View {
        List {

            if devMode {
                Section {
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
                    Button(action: devModeOff) {
                        Text("DevMode Off")
                    }
                    #if DEBUG
                    NavigationLink(destination: DevTools()) {
                        Label("Debug only tools", systemImage: "chevron.left.slash.chevron.right")
                    }
                    #endif
                }
            }
            Section {
                HStack {
                    Text("Current version")
                    Spacer()
                    Text("v\(version) (\(build))").onTapGesture(perform: onTapVersion)
                }
            }
        }
                .navigationBarTitle("About")
                .onAppear(perform: {
                    devMode =  UserDefaults.standard.bool(forKey: "DevMode")
                    (version, build) = getVersion()
                    (count, lastVersionPrompted) = getSessionCount()
                })
    }

    func onTapVersion() {
        tapVersion += 1
        if tapVersion >= 15 {
            UserDefaults.standard.set(true, forKey: "DevMode")
            devMode = true
        }
    }

    func devModeOff() {
        UserDefaults.standard.set(false, forKey: "DevMode")
        devMode = false
    }
}
