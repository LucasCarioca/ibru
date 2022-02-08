//
//  CollectionTile.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import SwiftUI
import QuickComponents

struct CollectionBrewTile: View {
    var brew: CollectionBrew
    @State var count: Int16 = 0
    init(brew: CollectionBrew) {
        self.brew = brew
        let count = brew.count
        _count = State(initialValue: count)
    }

    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(brew.name ?? "missing name")
                            .font(.title2)
                            .fontWeight(.heavy)
                    Spacer()
                }
                InfoLabel(label: "Bottle Count", value: "\(count)")
                InfoLabel(label: "Year", value: brew.year ?? "unknown")
            }
            Spacer()
            VStack {
                Button(action: { addBottle(amount: 1) }) {
                    Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                }
                        .buttonStyle(BorderlessButtonStyle())
                        .contentShape(Rectangle())
                Spacer()
                Button(action: { removeBottle(amount: 1) }) {
                    Image(systemName: "minus.circle.fill")
                            .imageScale(.large)
                }
                        .buttonStyle(BorderlessButtonStyle())
                        .contentShape(Rectangle())
            }
                    .padding()
        }
    }
    func removeBottle(amount: Int16) {
        if brew.count <= 0 {
            return
        }
        count = count - amount
        brew.count = count
        do {
            try brew.managedObjectContext!.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func addBottle(amount: Int16) {
        count = count + amount
        brew.count = count
        do {
            try brew.managedObjectContext!.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
