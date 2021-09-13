//
//  UpdateBottleRecord.swift
//  iBru
//
//  Created by Lucas Desouza on 9/11/21.
//

import SwiftUI

struct UpdateBottleRecord: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var gravity = ""
    @State var bottleCount = ""
    @State var date = Date()
    
    var bottle: Bottle
    
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
            Button("Save", action: addBrew)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }
            .onAppear() {
                self.gravity = String(bottle.finalGravity)
                self.bottleCount = String(bottle.count)
                self.date = bottle.date ?? Date()
            }
            .navigationTitle("Bottling")
    }
    
    private func addBrew() {
        withAnimation {
            bottle.date = date
            bottle.finalGravity = Double(gravity) ?? 1.000
            bottle.count = Int16(bottleCount) ?? 0
            do {
                try bottle.managedObjectContext!.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
        }
    }
}
