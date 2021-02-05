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
    @State var gravity = ""
    @State var date = Date()
    
    var brew: Brew
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .padding()
            TextField("Original gravity", text: $gravity)
                .keyboardType(.decimalPad)
                .padding()
            DatePicker("Start date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
            
            Button("Finish", action: updateBrew)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.onAppear() {
            self.name = brew.name!
            self.gravity = "\(brew.originalGravity)"
            self.date = brew.startDate!
        }.navigationTitle("Update brew")
    }
    
    private func updateBrew() {
        withAnimation {
            brew.startDate = date
            brew.name = name
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
