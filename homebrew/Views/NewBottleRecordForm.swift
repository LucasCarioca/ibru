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
    @State var date = Date()
    
    var brew: Brew
    
    var body: some View {
        Form {
            TextField("Final gravity", text: $gravity)
                .keyboardType(.decimalPad)
                .padding()
            DatePicker("Bottle date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
            Button("Finish", action: addBrew)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.navigationTitle("Record bottling")
    }
    
    private func addBrew() {
        withAnimation {
            let newItem = Bottle(context: brew.managedObjectContext!)
            newItem.date = date
            newItem.finalGravity = Double(gravity) ?? 1.000
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
