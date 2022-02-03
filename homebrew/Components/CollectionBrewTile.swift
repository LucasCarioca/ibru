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
    var onChange: () -> Void
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(brew.name ?? "missing name")
                            .font(.title2)
                            .fontWeight(.heavy)
                    Spacer()
                }
                InfoLabel(label: "Bottle Count", value: "\(brew.count)")
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
        brew.count = brew.count - amount
        do {
            try brew.managedObjectContext!.save()
            onChange()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func addBottle(amount: Int16) {
        brew.count = brew.count + amount
        do {
            try brew.managedObjectContext!.save()
            onChange()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
