//
//  SecondaryList.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI

struct SecondaryList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var category: BrewCategory = .ALL
    @FetchRequest(
            entity: Brew.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Brew.startDate, ascending: false)],
            predicate: NSPredicate(format: "bottles = nil and secondary != nil"),
            animation: .default)
    private var brews: FetchedResults<Brew>
    var body: some View {
        BrewList(brews: filterBrewList(brews, by: category), onEmpty: EmptySecondaryList()).navigationBarTitle("Secondary Fermentation").toolbar {
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


struct EmptySecondaryList: View {
    var body: some View {
        VStack {
            Text("Looks like you don't have any brews currently in Secondary fermentation yet.").Paragraph(align: .center, size: .MD)
            LottieView(filename: "empty")
            Spacer()
        }
    }
}

