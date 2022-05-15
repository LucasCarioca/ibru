//
//  PrimaryDetailView.swift
//  iBru
//
//  Created by Lucas Desouza on 4/19/22.
//

import SwiftUI

struct PrimaryDetailView: View {
    var brew: Brew
    var body: some View {
        VStack {
            Text("Primary Fermentation").bold().font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            InfoLabel(label: "Original Gravity", value: String(format: "%.3f", brew.originalGravity))
            InfoLabel(label: "Potential ABV", value: "\(String(format: "%.2f", (brew.originalGravity - 1) * 131.25))%")
            InfoLabel(label: "Start date", value: brewDateFormatter.string(from: brew.startDate ?? Date()))
            showAge().font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func showAge() -> AnyView {
        var brewAge = getAge(of: brew, fromBottlingDate: false, fromSecondary: false)
        var label = "days"
        if brewAge >= 30 {
            label = "months"
            brewAge = brewAge / 30
        }
        return AnyView(Text("\(String(format: "%.1f", brewAge)) \(label)"))
    }
}
