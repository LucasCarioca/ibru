//
//  BrewTile.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI

struct BrewTile: View {
    var brew: Brew
    var body: some View {
        NavigationLink(destination: BrewDetail(brew: brew)) {
            VStack{
                HStack {
                    Text(brew.name ?? "missing name")
                        .font(.title3)
                        .fontWeight(.heavy)
                    Spacer()
                }
                InfoLabel(label: "Stage", value: getStage(of: brew).rawValue)
                getBottleCount()
                InfoLabel(label: "Elapsed Time", value: getTimeText())
            }
        }
    }
    
    func getTimeText() -> String {
        var brewAge = getAge(of: brew)
        var label = "Days"
        if brewAge >= 30 {
            brewAge = brewAge / 30
            label = "Months"
        }
        return "\(String(format: "%.1f", brewAge)) \(label)"
    }
    
    func getBottleCount() -> AnyView {
        if getStage(of: brew) == .bottled {
            return AnyView(
                InfoLabel(label: "Bottle Count", value: "\(brew.bottles?.count ?? 0)")
            )
        }
        return AnyView(EmptyView())
    }
}
