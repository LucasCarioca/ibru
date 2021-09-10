//
//  CollectionList.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import SwiftUI
import CoreData

struct CollectionList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Brew.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Brew.startDate, ascending: false)],
        predicate: NSPredicate(format: "bottles != nil and bottles.count > 0"),
        animation: .default)
    
    private var brews: FetchedResults<Brew>
    
    var body: some View {
        List {
            ForEach(brews) { brew in
                CollectionTile(brew: brew)
            }.onDelete(perform: { offsets in
                withAnimation {
                    deleteBrew(offsets: offsets, brews: brews, context: viewContext)
                }
            })
        }.listStyle(PlainListStyle())
    }
}
