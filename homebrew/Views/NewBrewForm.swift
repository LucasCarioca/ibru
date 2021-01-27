//
//  NewBrewForm.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

struct NewBrewForm: View {

    @Environment(\.managedObjectContext) private var viewContext
    @State private var name = ""
    @State var gravity = ""
    @State var date = Date()

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
            
            Button("Finish", action: addBrew)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }
    }
    
    private func addBrew() {
        withAnimation {
            let newItem = Brew(context: viewContext)
            newItem.startDate = date
            newItem.name = name
            newItem.originalGravity = Double(gravity) ?? 1.000
            do {
                try viewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
