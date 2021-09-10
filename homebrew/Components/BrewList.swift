//
//  BrewList.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI

struct BrewList: View {
    var brews: FetchedResults<Brew>
    var body: some View {
        List {
            ForEach(brews) { brew in
                BrewTile(brew: brew)
            }
        }.listStyle(PlainListStyle())
        .modifier(NewBrewButtonModifier())
    }
}
