//
//  UpdateReading.swift
//  homebrew
//
//  Created by Lucas Desouza on 2/9/21.
//

import SwiftUI

struct UpdateReadingForm: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var gravity = ""
    @State var date = Date()

    var reading: Reading

    var body: some View {
        Form {
            TextField("Current Gravity", text: $gravity)
                    .keyboardType(.decimalPad)
                    .padding()
            DatePicker("Start date", selection: $date)
                    .datePickerStyle(GraphicalDatePickerStyle())
            Button("Finish", action: addBrew)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.onAppear() {
            self.gravity = "\(reading.gravity)"
            self.date = reading.date!
        }.navigationTitle("Update brew")
    }

    private func addBrew() {
        withAnimation {
            reading.date = date
            reading.gravity = Double(gravity) ?? 1.000
            do {
                try reading.managedObjectContext!.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
