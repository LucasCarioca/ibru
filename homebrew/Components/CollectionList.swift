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
    @State private var refreshID = UUID()
    
    var body: some View {
        VStack{
            getTotalBottleCount()
            List {
                ForEach(brews) { brew in
                    NavigationLink(destination: BrewDetail(brew: brew)) {
                        CollectionTile(brew: brew) {
                            self.refreshID = UUID()
                        }
                    }
                }.onDelete(perform: { offsets in
                    withAnimation {
                        deleteBrew(offsets: offsets, brews: brews, context: viewContext)
                    }
                })
            }
                .listStyle(PlainListStyle())
                
        }.id(refreshID)
    }
    
    func getTotalBottleCount() -> AnyView {
        var total: Int16 = 0
        for brew in brews {
            if let bottles = brew.bottles {
                total = total + bottles.count
            }
        }
        if total > 0 {
            return AnyView(
                VStack {
                    InfoLabel(label: "Collection Size", value: "\(total)")
                    Divider()
                }.padding(.horizontal)
            )
        }
        return AnyView(EmptyView())
    }
}
