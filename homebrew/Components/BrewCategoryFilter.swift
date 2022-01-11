//
// Created by Lucas Desouza on 1/10/22.
//

import SwiftUI

struct BrewCategoryFilter: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var filterCategory: BrewCategory
    var body: some View {
        List {
            HStack {
                Text("All").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                filterCategory == .ALL ? Image(systemName: "checkmark") : nil
            }.contentShape(Rectangle()).onTapGesture {
                filterCategory = .ALL
                presentationMode.wrappedValue.dismiss()
            }
            ForEach(BrewCategory.allValues, id: \.self) { category in
                HStack {
                    Text(category.rawValue).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    filterCategory == category ? Image(systemName: "checkmark") : nil
                }.contentShape(Rectangle()).onTapGesture {
                    filterCategory = category
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

func filterBrewList(_ list: FetchedResults<Brew>, by filter: BrewCategory) -> [Brew] {
    if filter == .ALL {
        return list.filter { _ in
            true
        }
    }
    return list.filter { brew in
        if let category = brew.category {
            return category == filter.rawValue
        }
        return false
    }
}
