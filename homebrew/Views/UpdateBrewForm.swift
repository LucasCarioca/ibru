//
//  UpdateBrewForm.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/28/21.
//

import SwiftUI

struct UpdateBrewForm: View {
    
    @State private var name = ""
    @State var gravity = ""
    @State var date = Date()
    
    var brew: Brew {
        didSet {
            self.name = brew.name!
            self.gravity = "\(brew.originalGravity)"
            self.date = brew.startDate!
        }
    }
    var dismiss: () -> Void
    
    var body: some View {
        Form {
            HStack {
                Text("New Brew")
                    .font(.title)
                Spacer()
                Button(action: dismiss) {
                    Image(systemName: "xmark")
                }
            }.padding()
            TextField("Name", text: $name)
                .padding()
            TextField("Original gravity", text: $gravity)
                .keyboardType(.decimalPad)
                .padding()
            DatePicker("Start date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
            
            Button("Finish", action: updateBrew)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }
    }
    
    private func updateBrew() {
        withAnimation {
            brew.startDate = date
            brew.name = name
            brew.originalGravity = Double(gravity) ?? 1.000
            do {
                try brew.managedObjectContext!.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
