//
//  Collection.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import SwiftUI

struct Collection: View {
    @State var selected = 1
    var body: some View {
        TabView(selection: $selected) {
            HomebrewCollectionList().tabItem {
                        Label("Homebrew", systemImage: "house")
                    }
                    .onTapGesture {
                        selected = 1
                    }
                    .tag(1)
            PurchasedCollectionList().tabItem {
                        Label("Purchased", systemImage: "dollarsign.circle.fill")
                    }
                    .onTapGesture {
                        selected = 2
                    }
                    .tag(2)
        }
                .toolbar {
//                        HStack {
                    selected == 2 ? AnyView(NavigationLink(destination: NewCollectionBrewForm()) {
                        Image(systemName: "plus")
                    }) : AnyView(EmptyView())
//                            if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
//                                NavigationLink(destination: BrewCategoryFilter(filterCategory: $category)) {
//                                    Image(systemName: "line.3.horizontal.decrease")
//                                }
//                            }
//                        }
                }
                .navigationTitle("Collection")
    }
}
