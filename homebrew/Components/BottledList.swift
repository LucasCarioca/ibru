//
//  BottledList.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI

struct BottledList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
            entity: Brew.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Brew.startDate, ascending: false)],
            predicate: NSPredicate(format: "bottles != nil"),
            animation: .default)
    private var brews: FetchedResults<Brew>
    var category: BrewCategory
    var body: some View {
        BrewList(brews: filterBrewList(brews, by: category), onEmpty: EmptyBottledList())
    }
}

struct EmptyBottledList: View {
    var body: some View {
        VStack {
            Text("Looks like you don't have any brews currently bottled.").Paragraph(align: .center, size: .MD)
            LottieView(filename: "empty")
            Spacer()
        }
    }
}
