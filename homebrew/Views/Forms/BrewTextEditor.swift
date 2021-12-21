//
// Created by Lucas Desouza on 12/4/21.
//

import Foundation
import SwiftUI

struct BrewTextEditor: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var title: String
    @State var text: String
    var onSave: (String) -> Void
    var body: some View {
        VStack {
            TextEditor(text: self.$text).padding()
            Spacer()
            Button(action: save) {
                Text("Save")
            }.padding()
        }.navigationTitle(title)
    }

    func save() {
        onSave(text)
        presentationMode.wrappedValue.dismiss()
    }
}