//
//  BottleDetailView.swift
//  iBru
//
//  Created by Lucas Desouza on 4/19/22.
//

import SwiftUI

struct BottleDetailView: View {
    var brew: Brew
    var body: some View {
        VStack {
            Text("Bottled").bold().font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                InfoLabel(label: "Bottle count", value: "\(brew.bottles?.count ?? 0)")
            }
            InfoLabel(label: "Final gravity", value: String(format: "%.3f", brew.bottles?.finalGravity ?? 0))
            InfoLabel(label: "Final ABV", value: "\(String(format: "%.2f", (brew.originalGravity - (brew.bottles?.finalGravity ?? 0)) * 131.25))%")
            InfoLabel(label: "End date", value: brewDateFormatter.string(from: brew.bottles?.date ?? Date()))
            showAge().font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func showAge() -> AnyView {
        var brewAge = getAge(of: brew, fromBottlingDate: true, fromSecondary: false)
        var label = "days"
        if brewAge >= 30 {
            label = "months"
            brewAge = brewAge / 30
        }
        return AnyView(Text("\(String(format: "%.1f", brewAge)) \(label)"))
    }
}
