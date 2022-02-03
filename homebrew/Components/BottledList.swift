//
//  BottledList.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI

struct BottledList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var category: BrewCategory = .ALL
    @FetchRequest(
            entity: Brew.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Brew.startDate, ascending: false)],
            predicate: NSPredicate(format: "bottles != nil"),
            animation: .default)
    private var brews: FetchedResults<Brew>
    var body: some View {
        BrewList(brews: filterBrewList(brews, by: category), onEmpty: EmptyBottledList()).navigationBarTitle("Bottled").toolbar {
            HStack {
                NavigationLink(destination: NewBrewForm()) {
                    Image(systemName: "plus")
                }
                NavigationLink(destination: BrewCategoryFilter(filterCategory: $category)) {
                    Image(systemName: "line.3.horizontal.decrease")
                }
            }
        }
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
