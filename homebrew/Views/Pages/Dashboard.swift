//
//  Dashboard.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI
import QuickComponents

struct Dashboard: View {
    @State var category: BrewCategory = .ALL
    var body: some View {
        TabView {
            PrimaryList(category: category).tabItem {
                Label("Primary", systemImage: "1.circle.fill")
            }
            SecondaryList(category: category).tabItem {
                Label("Secondary", systemImage: "2.circle.fill")
            }
            BottledList(category: category).tabItem {
                Label("Bottled", systemImage: "circle.fill")
            }
        }
                .toolbar {
                    HStack {
                        NavigationLink(destination: NewBrewForm()) {
                            Image(systemName: "plus")
                        }
                        NavigationLink(destination: BrewCategoryFilter(filterCategory: $category)) {
                            Image(systemName: "line.3.horizontal.decrease")
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
