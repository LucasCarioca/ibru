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
    var body: some View {
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

