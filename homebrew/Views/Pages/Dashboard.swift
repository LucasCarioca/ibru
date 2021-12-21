//
//  Dashboard.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI
import QuickComponents

struct Dashboard: View {
    var body: some View {
        TabView {
            PrimaryList().tabItem {
                Label("Primary", systemImage: "1.circle.fill")
            }
            SecondaryList().tabItem {
                Label("Secondary", systemImage: "2.circle.fill")
            }
            BottledList().tabItem {
                Label("Bottled", systemImage: "circle.fill")
            }
        }
                .toolbar {
                    NavigationLink(destination: NewBrewForm()) {
                        HStack{
                            Image(systemName: "plus")
                            Text("New Brew")
                        }
                    }
                }
                .navigationTitle("Dashboard")
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
