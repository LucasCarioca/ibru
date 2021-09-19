//
//  Brews.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI
import CoreData
import QuickComponents

struct Brews: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Brew.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Brew.startDate, ascending: false)],
        animation: .default)
    private var brews: FetchedResults<Brew>
    @State var refreshId = UUID()

    var body: some View {
        if brews.count <= 0 {
            EmptyList().navigationTitle("Brews")
        } else {
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
}

struct EmptyList: View {
    var body: some View {
        VStack {
            Text("Looks like you don't have any brews yet. Get some started now!").Paragraph(align: .center, size: .MD)
            LottieView(filename: "empty")
            Spacer()
            NavigationLink(destination: NewBrewForm()){
                Text("Start brewing")
            }
                .buttonStyle(PrimaryButton(variant: .contained))
                .frame(width: 150, height: 75)
                .padding(.bottom, 50)
        }
    }
}
