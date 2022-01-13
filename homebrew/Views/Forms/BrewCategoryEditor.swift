//
// Created by Lucas Desouza on 12/4/21.
//

import Foundation
import SwiftUI

struct BrewCategoryEditor: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var onSave: (BrewCategory) -> Void
    var currentCategory: BrewCategory
    var body: some View {
        List {
            ForEach(BrewCategory.allValues, id: \.self) { category in
                HStack {
                    Text(category.rawValue).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    currentCategory == category ? Image(systemName: "checkmark") : nil
                }.contentShape(Rectangle()).onTapGesture {
                    onSave(category)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}