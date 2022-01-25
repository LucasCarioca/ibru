//
//  NewBrewForm.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

struct NewCollectionBrewForm: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @State var name = ""
    @State var abv = ""
    @State var category = ""
    @State var year = ""
    @State var bottleCount = ""

    var body: some View {
        Form {
            TextField("Name", text: $name)
                    .padding()
            TextField("Alcohol Content", text: $abv)
                    .keyboardType(.decimalPad)
                    .padding()
            TextField("Year", text: $year)
                    .keyboardType(.decimalPad)
                    .padding()
            TextField("Bottle count", text: $bottleCount)
                    .keyboardType(.decimalPad)
                    .padding()
            Picker(selection: $category, label: Text("Category")) {
                Text("None").tag(nil as String?)
                ForEach(BrewCategory.allValues, id: \.self) { category in
                    Text(category.rawValue).tag(category.rawValue)
                }
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            Button("Finish", action: addBrew)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.navigationTitle("New Collection brew")
    }

    private func addBrew() {
        withAnimation {
            let newItem = CollectionBrew(context: viewContext)
            print(newItem)
            newItem.year = year
            newItem.name = name
            newItem.category = category
            newItem.abv = Double(abv) ?? 1.000
            newItem.count = Int16(bottleCount) ?? 1
            print(newItem)
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
