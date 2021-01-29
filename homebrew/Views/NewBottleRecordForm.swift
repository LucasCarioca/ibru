//
//  SwiftUIView.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

struct NewBottleRecordForm: View {
    @State var gravity = ""
    @State var date = Date()
    @Binding var shown: Bool
    
    var brew: Brew
    var dismiss: () -> Void
    
    var body: some View {
        Group {
            if shown {
                Form {
                    HStack {
                        Text("Record Bottling")
                            .font(.title)
                        Spacer()
                        Button(action: dismiss) {
                            Image(systemName: "xmark")
                        }
                    }.padding()
                    TextField("Final gravity", text: $gravity)
                        .keyboardType(.decimalPad)
                        .padding()
                    DatePicker("Bottle date", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    Button("Finish", action: addBrew)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
    
    private func addBrew() {
        withAnimation {
            let newItem = Bottle(context: brew.managedObjectContext!)
            newItem.date = date
            newItem.finalGravity = Double(gravity) ?? 1.000
            brew.bottles = newItem
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
