//
//  BrewingList.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI
import QuickComponents
struct PrimaryList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Brew.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Brew.startDate, ascending: false)],
        predicate: NSPredicate(format: "bottles = nil and secondary = nil"),
        animation: .default)
    
    private var brews: FetchedResults<Brew>
    
    var body: some View {
        BrewList(brews: brews, onEmpty: EmptyPrimaryList())
    }
}

struct EmptyPrimaryList: View {
    var body: some View {
        VStack {
            Text("Looks like you don't have any brews currently in primary fermentation. Get some started now!").Paragraph(align: .center, size: .MD)
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
