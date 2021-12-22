//
//  SGCalculator.swift
//  iBru
//
//  Created by Lucas Desouza on 9/7/21.
//

import SwiftUI

struct SGCalculator: View {
    @Environment(\.sugarService) var sugarService: SugarService
    @State var sugars = [Sugar]()
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
                ForEach(0..<sugars.count, id: \.self) {
                    Text(sugars[$0].name).tag($0 as Int?)
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
        }
                .task {
                    await loadSugars()
                }
                .navigationTitle("Gravity Estimator")
    }

    private func calculate() {
        if let sugar = sugar {
            let quantityConverted = Double(quantity) ?? 0.00
            let batchSizeConverted = Double(batchSize) ?? 0.00
            result = quantityConverted * (sugars[sugar].gravityPerPound / batchSizeConverted)
        }
    }

    func loadSugars() async {
        sugars = await sugarService.getSugars()
    }

}

struct SGCalculator_Previews: PreviewProvider {
    static var previews: some View {
        SGCalculator()
    }
}
