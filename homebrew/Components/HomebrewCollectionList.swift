//
//  CollectionList.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import SwiftUI
import CoreData

struct HomebrewCollectionList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
            entity: Brew.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Brew.startDate, ascending: false)],
            predicate: NSPredicate(format: "bottles != nil and bottles.count > 0"),
            animation: .default)
    private var brews: FetchedResults<Brew>
    @State private var refreshID = UUID()

    var body: some View {
        if brews.count <= 0 {
            EmptyCollectionList()
        } else {
            List {
                Section {
                    getBrewCount()
                    getTotalBottleCount()
                }
                Section {
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
            }.id(refreshID)
        }
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
                        Text("Total bottles").badge(Int(total))
            )
        }
        return AnyView(EmptyView())
    }
    func getBrewCount() -> AnyView {
        let total = brews.count
        if total > 0 {
            return AnyView(
                    Text("Brews").badge(total)
            )
        }
        return AnyView(EmptyView())
    }
}


struct EmptyCollectionList: View {
    var body: some View {
        VStack {
            Text("Your collection looks empty. To add to your collection you first need to complete fermentation and bottle a batch. Batches stay in your collection view only if you have remaining bottles.").Paragraph(align: .center, size: .MD)
            LottieView(filename: "empty")
            Spacer()
        }
    }
}
