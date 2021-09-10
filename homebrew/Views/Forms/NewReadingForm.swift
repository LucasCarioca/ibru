//
//  NewReadingForm.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

struct NewReadingForm: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var gravity = ""
    @State var date = Date()
    
    var brew: Brew
    
    var body: some View {
        Form {
            TextField("Current Gravity", text: $gravity)
                .keyboardType(.decimalPad)
                .padding()
            DatePicker("Start date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
            Button("Finish", action: addBrew)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.navigationTitle("New reading")
    }
    
    private func addBrew() {
        withAnimation {
            let newItem = Reading(context: brew.managedObjectContext!)
            newItem.date = date
            newItem.gravity = Double(gravity) ?? 1.000
            brew.addToReadings(newItem)
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

