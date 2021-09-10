//
//  Brews.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI
import CoreData

struct Brews: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Brew.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Brew.startDate, ascending: false)],
        animation: .default)
    private var brews: FetchedResults<Brew>
    @State var refreshId = UUID()

    var body: some View {
            List {
                ForEach(brews) { brew in
                    NavigationLink(destination: BrewDetail(brew: brew)) {
                        HStack {
                            Text(brew.name ?? "Name missing")
                            Spacer()
                            Text("\(brew.startDate!, formatter: brewDateFormatter)")
                        }
                    }
                }.onDelete(perform: { offsets in
                    withAnimation {
                        deleteBrew(offsets: offsets, brews: brews, context: viewContext)
                    }
                })
                Spacer().padding(.vertical, 50)
            }.listStyle(PlainListStyle())
            .navigationTitle("Brews")
            .modifier(NewBrewButtonModifier(onDisappear: {
                self.refreshId = UUID()
            }))
    }
}
