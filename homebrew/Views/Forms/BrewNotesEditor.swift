//
// Created by Lucas Desouza on 12/4/21.
//

import Foundation
import SwiftUI

struct BrewNotesEditor: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var notes: String
    var onSave: (String) -> Void
    var body: some View {
        VStack {
            TextEditor(text: self.$notes).padding()
            Spacer()
            Button(action: save) {
                Text("Save")
            }.padding()
        }.navigationTitle("Notes")
    }

    func save() {
        onSave(notes)
        presentationMode.wrappedValue.dismiss()
    }
}