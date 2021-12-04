//
// Created by Lucas Desouza on 12/4/21.
//

import Foundation
import SwiftUI

struct BrewNotesEditor: View {
    @State var notes: String
    var onSave: (String) -> Void
    var body: some View {
        VStack {
            TextEditor(text: self.$notes).padding()
            Spacer()
            Button(action: save) {
                Text("Save")
            }.padding()
        }
    }

    func save() {
        onSave(notes)
    }
}