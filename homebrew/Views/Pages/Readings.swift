//
//  Readings.swift
//  iBru
//
//  Created by Lucas Desouza on 11/19/21.
//

import SwiftUI

struct Readings: View {
    var brew: Brew
    @State private var refreshID = UUID()
    var body: some View {
        ZStack {
            List {
                ForEach(getReadingList(), id: \.self) { reading in
                    NavigationLink(destination: UpdateReadingForm(reading: reading).onDisappear(perform: refresh)) {
                        GravityReading(date: reading.date ?? Date(), gravity: reading.gravity, originalGravity: brew.originalGravity)
                    }
                }.onDelete(perform: deleteItems)
            }
            showButtons()
        }
                .navigationTitle("Readings")
                .id(refreshID)
    }

    private func getReadingList() -> [Reading] {
        let set = brew.readings! as? Set<Reading> ?? []
        return set.sorted {
            $0.date! < $1.date!
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            let readingList = getReadingList()
            offsets.map {
                readingList[$0]
            }.forEach(brew.managedObjectContext!.delete)
            do {
                try brew.managedObjectContext!.save()
                refresh()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func showButtons() -> AnyView {
        if let _ = brew.bottles {
            return AnyView(EmptyView())
        }
        return AnyView(VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: NewReadingForm(brew: brew).onDisappear(perform: refresh)) {
                    Image("testtube").colorInvert()
                            .font(.system(.largeTitle))
                            .frame(width: 67, height: 67)
                            .background(Color.accentColor)
                            .cornerRadius(50)
                            .padding(.vertical)
                            .padding(.trailing, 12)
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                }
            }
        })
    }

    private func refresh() {
        refreshID = UUID()
    }
}
