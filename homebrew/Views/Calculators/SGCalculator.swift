//
//  SGCalculator.swift
//  iBru
//
//  Created by Lucas Desouza on 9/7/21.
//

import SwiftUI


struct SugarType: Hashable {
    var name: String
    var points: Double
}

let sugars = [
    SugarType(name: "Honey", points: 0.035),
    SugarType(name: "Sugar", points: 0.042)
]

struct SGCalculator: View {
    var sugars = [
        SugarType(name: "Dry Malt Extract", points: 0.044),
        SugarType(name: "Honey", points: 0.035),
        SugarType(name: "Liquid Malt Extract", points: 0.036),
        SugarType(name: "Molasses", points: 0.036),
        SugarType(name: "Honey", points: 0.046),
        SugarType(name: "Wheat Malt", points: 0.029),
        SugarType(name: "Wheat Torrefied", points: 0.027),
        SugarType(name: "2-Row Pale Malt", points: 0.027),
    ]
    @State var sugar: Int? = nil
    @State var quantity = ""
    @State var batchSize = ""
    @State var result: Double = 0.0
    var body: some View {
        Form {
            Text("\(result)")
                    .font(.largeTitle)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            Picker(selection: $sugar, label: Text("Sugar source")) {
                Text("None").tag(nil as Int?)
                ForEach(0..<sugars.count) {
                    Text(self.sugars[$0].name).tag($0 as Int?)
                }
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            TextField("Sugar Quantity (pounds)", text: $quantity)
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            TextField("Batch size (gallons)", text: $batchSize)
                    .keyboardType(.decimalPad)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            Button(action: calculate) {
                Text("Calculate")
            }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }.navigationTitle("Gravity Estimator")
    }

    private func calculate() {
        if let sugar = self.sugar {
            let quantityConverted = Double(quantity) ?? 0.00
            let batchSizeConverted = Double(batchSize) ?? 0.00
            result = quantityConverted * (sugars[sugar].points / batchSizeConverted)
        }
    }
}

struct SGCalculator_Previews: PreviewProvider {
    static var previews: some View {
        SGCalculator()
    }
}
