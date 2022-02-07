//
//  NewSecondaryRecord.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI

struct UpdateSecondaryRecord: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var gravity = ""
    @State var date = Date()

    var secondary: Secondary

    init(secondary current: Secondary) {
        secondary = current
        _gravity = State(initialValue: "\(current.gravity)")
        _date = State(initialValue: current.date ?? Date())
    }

    var body: some View {
        Form {
            TextField("Current gravity", text: $gravity)
                    .keyboardType(.decimalPad)
                    .padding()
            DatePicker("Bottle date", selection: $date)
                    .datePickerStyle(GraphicalDatePickerStyle())
            Button("Finish", action: updateSecondary)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }
                .onAppear() {
                    self.gravity = String(secondary.gravity)
                    self.date = secondary.date ?? Date()
                }
                .navigationTitle("Secondary")
    }

    private func updateSecondary() {
        withAnimation {
            secondary.gravity = Double(gravity) ?? 1.000
            secondary.date = date
            do {
                try secondary.managedObjectContext!.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
