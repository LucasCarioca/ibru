//
//  NewSecondaryRecord.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI

struct NewSecondaryRecord: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var gravity = ""
    @State var date = Date()

    var brew: Brew

    var body: some View {
        Form {
            TextField("Current gravity", text: $gravity)
                    .keyboardType(.decimalPad)
                    .padding()
            DatePicker("Bottle date", selection: $date)
                    .datePickerStyle(GraphicalDatePickerStyle())
            Button("Finish", action: addSecondary)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.navigationTitle("Secondary")
    }

    private func addSecondary() {
        withAnimation {
            let newItem = Secondary(context: brew.managedObjectContext!)
            newItem.date = date
            newItem.gravity = Double(gravity) ?? 1.000
            brew.secondary = newItem
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
