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
    
    var body: some View {
        BrewList(brews: brews)
    }
}
