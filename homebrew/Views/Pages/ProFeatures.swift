//
//  ProFeatures.swift
//  iBru
//
//  Created by Lucas Desouza on 9/17/21.
//

import SwiftUI
import QuickComponents

struct ProFeatures: View {
    @StateObject var storeManager = StoreManager()
    
    var body: some View {
        if !UserDefaults.standard.bool(forKey: StoreManager.productKey) {
            VStack {
                Text("Upgrade to Pro").Heading(align: .center, size: .H1)
                Text("Enable all advanced features like the Collection to manage previous batches and the Dashboard to monitor your brews at its different stages.").Paragraph(align: .center, size: .MD)
                Spacer()
                Button(action: initiatePurchase) {
                    Text("Upgrade Now")
                }
                    .buttonStyle(PrimaryButton(variant: .contained))
                    .frame(width: 150, height: 75)
            }
        } else {
            VStack {
                Text("Thank you for your purchase").Heading(align: .center, size: .H3)
                Spacer()
            }
        }
    }
    
    func initiatePurchase() {
        let product = storeManager.myProducts[0]
        storeManager.purchaseProduct(product: product)
    }
}

struct ProFeatures_Previews: PreviewProvider {
    static var previews: some View {
        ProFeatures()
    }
}
