//
//  SecondaryDetailView.swift
//  iBru
//
//  Created by Lucas Desouza on 4/19/22.
//

import SwiftUI

struct SecondaryDetailView: View {
    var brew: Brew
    var body: some View {
        VStack {
            Text("Secondary Fermentation").bold().font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            InfoLabel(label: "Gravity", value: String(format: "%.3f", brew.secondary?.gravity ?? 0))
            InfoLabel(label: "ABV", value: "\(String(format: "%.2f", (brew.originalGravity - (brew.secondary?.gravity ?? 0)) * 131.25))%")
            InfoLabel(label: "Start date", value: brewDateFormatter.string(from: brew.secondary?.date ?? Date()))
            showAge().font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func showAge() -> AnyView {
        var brewAge = getAge(of: brew, fromBottlingDate: false, fromSecondary: true)
        var label = "days"
        if brewAge >= 30 {
            label = "months"
            brewAge = brewAge / 30
        }
        return AnyView(Text("\(String(format: "%.1f", brewAge)) \(label)"))
    }
}
