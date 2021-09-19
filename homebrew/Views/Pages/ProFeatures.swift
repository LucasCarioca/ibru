//
//  ProFeatures.swift
//  iBru
//
//  Created by Lucas Desouza on 9/17/21.
//

import SwiftUI
import QuickComponents

struct ProFeatures: View {
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        if let transactionState = storeManager.transactionState {
            switch transactionState {
            case .purchasing:
                VStack {
                    Text("Processing").Heading(align: .center)
                    LottieView(filename: "payment-loading")
                    Spacer()
                }
            case .purchased:
                VStack {
                    Text("Purchase complete!").Heading(align: .center)
                    Text("Pro features are now enabled. Go back to the main menu to see the new views.").Paragraph(align: .center, size: .MD)
                    LottieView(filename: "payment-confirmation")
                    Spacer()
                }
            case .restored:
                VStack {
                    Text("Purchase complete!").Heading(align: .center)
                    Text("Pro features are now enabled. Go back to the main menu to see the new views.").Paragraph(align: .center, size: .MD)
                    LottieView(filename: "payment-confirmation")
                    Spacer()
                }
            case .failed, .deferred:
                VStack {
                    Text("Purchase failed!").Heading(align: .center)
                    Text("Something went wrong while processing your payment. Please try again.").Paragraph(align: .center, size: .MD)
                    LottieView(filename: "payment-error")
                    Spacer()
                    Button(action: {storeManager.transactionState = nil}) {
                        Text("Try again")
                    }
                        .buttonStyle(SecondaryButton(variant: .contained))
                        .frame(width: 150, height: 75)
                        .padding(.bottom, 50)
                }
            default:
                VStack {
                    LottieView(filename: "payment-loading")
                    Spacer()
                }
            }
        } else {
            TabView{
                VStack {
                    Text("Manage your current brews").Heading(align: .center, size: .H4)
                    Spacer()
                    LottieView(filename: "preparing")
                    Spacer()
                }
                VStack {
                    Text("Track your collection").Heading(align: .center, size: .H4)
                    Spacer()
                    LottieView(filename: "wine-loading")
                    Spacer()
                }
                VStack {
                    Text("Upgrade to Pro").Heading(align: .center, size: .H1)
                    Spacer()
                    LottieView(filename: "rocket")
                    Spacer()
                    Button(action: initiatePurchase) {
                        Text("Upgrade Now")
                    }
                        .buttonStyle(PrimaryButton(variant: .contained))
                        .frame(width: 150, height: 75)
                        .padding(.bottom, 50)
                }
            }.tabViewStyle(PageTabViewStyle())
        }
    }
    
    func initiatePurchase() {
        let product = storeManager.myProducts[0]
        storeManager.purchaseProduct(product: product)
    }
}

