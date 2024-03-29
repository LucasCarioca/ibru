//
//  BrewList.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI

struct BrewList: View {
    @Environment(\.managedObjectContext) private var viewContext
    var brews: [Brew]
    var onEmpty: AnyView

    public init<V>(brews: [Brew], onEmpty: V) where V: View {
        self.brews = brews
        self.onEmpty = AnyView(onEmpty)
    }

    @State var refreshId = UUID()

    var body: some View {
        if brews.count <= 0 {
            onEmpty
        } else {
            List {
                ForEach(brews) { brew in
                    NavigationLink(destination: BrewDetail(brew: brew).onDisappear() {
                        refreshId = UUID()
                    }) {
                        BrewTile(brew: brew)
                    }
                }.onDelete(perform: { offsets in
                    withAnimation {
                        deleteBrew(offsets: offsets, brews: brews, context: viewContext)
                    }
                })
            }

        }
    }
}

