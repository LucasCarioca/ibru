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
    @State var category: BrewCategory = .ALL
    @State var refreshId = UUID()

    var body: some View {
        if brews.count <= 0 {
            EmptyList().navigationTitle("Brews")
        } else {
            NavigationView {
                List {
                    ForEach(filterBrewList(brews, by: category)) { brew in
                        NavigationLink(destination: BrewDetail(brew: brew)) {
                            VStack {
                                HStack {
                                    Text(brew.name ?? "Name missing")
                                            .fontWeight(.heavy)
                                    Spacer()
                                    Text("\(brew.startDate!, formatter: brewDateFormatter)")
                                }
                                if let category = brew.category {
                                    category.count > 0 ? InfoLabel(label: "Category", value: category) : nil
                                }
                            }
                        }
                    }
                            .onDelete(perform: { offsets in
                                withAnimation {
                                    deleteBrew(offsets: offsets, brews: brews, context: viewContext)
                                }
                            })
                }
                        .toolbar {
                            HStack {
                                NavigationLink(destination: NewBrewForm()) {
                                    Image(systemName: "plus")
                                }
                                if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                                    NavigationLink(destination: BrewCategoryFilter(filterCategory: $category)) {
                                        Image(systemName: "line.3.horizontal.decrease")
                                    }
                                }
                            }
                        }
                        .navigationTitle("Brews")
            }
        }
    }
}

struct EmptyList: View {
    var body: some View {
        VStack {
            Text("Looks like you don't have any brews yet. Get some started now!").Paragraph(align: .center, size: .MD)
            LottieView(filename: "empty")
            Spacer()
            NavigationLink(destination: NewBrewForm()) {
                Text("Start brewing")
            }
                    .buttonStyle(PrimaryButton(variant: .contained))
                    .frame(width: 150, height: 75)
                    .padding(.bottom, 50)
        }
    }
}
