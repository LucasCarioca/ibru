//
//  SecondaryList.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI

struct SecondaryList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
            entity: Brew.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Brew.startDate, ascending: false)],
            predicate: NSPredicate(format: "bottles = nil and secondary != nil"),
            animation: .default)
    private var brews: FetchedResults<Brew>

    var body: some View {
        BrewList(brews: brews, onEmpty: EmptySecondaryList())
    }
}


struct EmptySecondaryList: View {
    var body: some View {
        VStack {
            Text("Looks like you don't have any brews currently in Secondary fermentation yet.").Paragraph(align: .center, size: .MD)
            LottieView(filename: "empty")
            Spacer()
        }
    }
}

