//
//  UpdateBrewForm.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/28/21.
//

import SwiftUI

struct UpdateBrewForm: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var name = ""
    @State var comment = ""
    @State var showDescriptionEditor = false
    @State var gravity = ""
    @State var category = ""
    @State var date = Date()

    var brew: Brew

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
            if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                Picker(selection: $category, label: Text("Category")) {
                    Text("None").tag(nil as String?)
                    ForEach(BrewCategory.allValues, id: \.self) { category in
                        Text(category.rawValue).tag(category.rawValue)
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
            DatePicker("Start date", selection: $date)
                    .datePickerStyle(GraphicalDatePickerStyle())

            Button("Finish", action: updateBrew)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.onAppear() {
            self.name = brew.name!
            self.comment = brew.comment ?? ""
            if category == "" {
                if let category = brew.category {
                    self.category = category
                }
            }
            self.gravity = "\(brew.originalGravity)"
            self.date = brew.startDate!
        }.sheet(isPresented: $showDescriptionEditor) {
            VStack {
                TextEditor(text: self.$comment).padding()
                Spacer()
                Button(action: {
                    self.showDescriptionEditor = false
                }) {
                    Text("Save")
                }.padding()
            }
        }.navigationTitle("Update brew")
    }

    private func updateBrew() {
        withAnimation {
            brew.startDate = date
            brew.name = name
            brew.comment = comment
            brew.category = category
            brew.originalGravity = Double(gravity) ?? 1.000
            do {
                try brew.managedObjectContext!.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
