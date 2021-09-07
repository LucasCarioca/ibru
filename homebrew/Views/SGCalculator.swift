//
//  SGCalculator.swift
//  iBru
//
//  Created by Lucas Desouza on 9/7/21.
//

import SwiftUI

struct SGCalculator: View {
    @State var pointsPerPound = ""
    @State var quantity = ""
    @State var batchSize = ""
    @State var result: Double = 0.0
    var body: some View {
        Form {
            Text("\(result)")
                .font(.largeTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            TextField("Fermentable Sugar", text: $pointsPerPound)
                .keyboardType(.decimalPad)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            TextField("Sugar Quantity (pounds)", text: $quantity)
                .keyboardType(.decimalPad)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            TextField("Batch size (gallons)", text: $batchSize)
                .keyboardType(.decimalPad)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            Button(action: calculate){
                Text("Calculate")
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.navigationTitle("ABV Calculator")
    }
    
    private func calculate() {
        let pointsPerPoundConverted = Double(pointsPerPound) ?? 0.00
        let quantityConverted = Double(quantity) ?? 0.00
        let batchSizeConverted = Double(batchSize) ?? 0.00
        result = quantityConverted * (pointsPerPoundConverted / batchSizeConverted)
    }
}

struct SGCalculator_Previews: PreviewProvider {
    static var previews: some View {
        SGCalculator()
    }
}
