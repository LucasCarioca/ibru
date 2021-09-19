//
//  BrewList.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI

struct BrewList: View {
    @Environment(\.managedObjectContext) private var viewContext
    var brews: FetchedResults<Brew>
    var onEmpty: AnyView
    
    public init<V>(brews: FetchedResults<Brew>, onEmpty: V) where V : View {
        self.brews = brews
        self.onEmpty = AnyView(onEmpty)
    }
    
    var body: some View {
        if brews.count <= 0 {
            onEmpty
        } else {
            List {
                ForEach(brews) { brew in
                    BrewTile(brew: brew)
                }.onDelete(perform: { offsets in
                    withAnimation {
                        deleteBrew(offsets: offsets, brews: brews, context: viewContext)
                    }
                })
            }.listStyle(PlainListStyle())
            .modifier(NewBrewButtonModifier())
        }
    }
}

