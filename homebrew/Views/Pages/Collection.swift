//
//  Collection.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import SwiftUI

struct Collection: View {
    var body: some View {
        VStack {
            CollectionList()
        }.navigationTitle("Collection")
    }
}

struct Collection_Previews: PreviewProvider {
    static var previews: some View {
        Collection()
    }
}