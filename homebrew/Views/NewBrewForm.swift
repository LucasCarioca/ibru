//
//  NewBrewForm.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

struct NewBrewForm: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @State var name = ""
    @State var comment = ""
    @State var showDescriptionEditor = false
    @State var gravity = ""
    @State var date = Date()
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .padding()
            Button(action: {
                    showDescriptionEditor = true
            }) {
                comment == "" ? Text("Description").foregroundColor(.gray) : Text(comment).foregroundColor(.primary)
            }.padding()
            TextField("Original gravity", text: $gravity)
                .keyboardType(.decimalPad)
                .padding()
            DatePicker("Start date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
            Button("Finish", action: addBrew)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.sheet(isPresented: $showDescriptionEditor) {
            VStack {
                TextEditor(text: self.$comment).padding()
                Spacer()
                Button(action: {
                    self.showDescriptionEditor = false
                }){
                  Text("Save")
                }.padding()
            }
            
        }.navigationTitle("New brew")
    }
    
    private func addBrew() {
        withAnimation {
            let newItem = Brew(context: viewContext)
            newItem.startDate = date
            newItem.name = name
            newItem.comment = comment
            newItem.originalGravity = Double(gravity) ?? 1.000
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
