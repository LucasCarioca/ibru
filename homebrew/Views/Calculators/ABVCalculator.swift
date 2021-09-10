//
//  ABVCalculator.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/28/21.
//

import SwiftUI

struct ABVCalculator: View {
    @State var og = ""
    @State var fg = ""
    @State var result: Double = 0.0
    var body: some View {
        Form {
            Text("\(result)")
                .font(.largeTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)

            HStack {
                TextField("Original Gravity", text: $og)
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                Spacer()
                Image(systemName: "arrow.forward")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                Spacer()
                TextField("Final Gravity", text: $fg)
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
            Button(action: calculate){
                Text("Calculate")
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.navigationTitle("ABV Calculator")
    }
    
    private func calculate() {
        let ogConverted = Double(og) ?? 0.00
        let fgConverted = Double(fg) ?? 0.00
        result = (ogConverted - fgConverted) * 131.25
    }
}

struct ABVCalculator_Previews: PreviewProvider {
    static var previews: some View {
        ABVCalculator()
    }
}
