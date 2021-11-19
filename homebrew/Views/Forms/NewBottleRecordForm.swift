//
//  SwiftUIView.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

struct NewBottleRecordForm: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var gravity = ""
    @State var bottleCount = ""
    @State var date = Date()
    
    var brew: Brew
    
    var body: some View {
        Form {
            TextField("Final gravity", text: $gravity)
                .keyboardType(.decimalPad)
                .padding()
            TextField("Bottle count", text: $bottleCount)
                .keyboardType(.decimalPad)
                .padding()
            DatePicker("Bottle date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
            Button("Finish", action: addBottle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.navigationTitle("Bottling")
    }
    
    private func addBottle() {
        withAnimation {
            let newItem = Bottle(context: brew.managedObjectContext!)
            newItem.date = date
            newItem.finalGravity = Double(gravity) ?? 1.000
            newItem.count   = Int16(bottleCount) ?? 1
            brew.bottles = newItem
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
