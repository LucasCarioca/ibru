//
//  BrewTile.swift
//  iBru
//
//  Created by Lucas Desouza on 9/9/21.
//

import SwiftUI
import QuickComponents

struct BrewTile: View {
    var brew: Brew
    @State var refreshId = UUID()
    var body: some View {
        NavigationLink(destination: BrewDetail(brew: brew).onDisappear() {
            refreshId = UUID()
        }) {
            VStack {
                HStack {
                    Text(brew.name ?? "missing name")
                            .font(.title3)
                            .fontWeight(.heavy)
                    Spacer()
                }
                getBottleCountView()
                InfoLabel(label: "Elapsed Time", value: getTimeText())
                getCurrentABVView()
                getProgressBarView()
            }
        }.id(refreshId)
    }

    func getTimeText() -> String {
        let stage = getStage(of: brew)
        var brewAge = getAge(of: brew,
                fromBottlingDate: (stage == .bottled),
                fromSecondary: (stage == .secondary))
        var label = "Days"
        if brewAge >= 30 {
            brewAge = brewAge / 30
            label = "Months"
        }
        return "\(String(format: "%.1f", brewAge)) \(label)"
    }

    func getCurrentABVView() -> AnyView {
        let stage = getStage(of: brew)
        if stage == .primary || stage == .secondary {
            let abv = getCurrentABV(of: brew)
            return AnyView(
                    InfoLabel(label: "Current ABV", value: "\(String(format: "%.2f", abv))%")
            )
        }
        return AnyView(EmptyView())
    }

    func getBottleCountView() -> AnyView {
        if getStage(of: brew) == .bottled {
            return AnyView(
                    InfoLabel(label: "Bottle Count", value: "\(brew.bottles?.count ?? 0)")
            )
        }
        return AnyView(EmptyView())
    }

    func getProgressBarView() -> AnyView {
        let stage = getStage(of: brew)
        if stage == .primary {
            let change = brew.originalGravity - getCurrentGravity(of: brew)
            let percentComplete = (100 * change) / (brew.originalGravity - 1)
            return AnyView(
                    BarView(percent: CGFloat(percentComplete), showLabel: false, color: .accentColor)
                            .padding(.bottom)
            )
        }
        return AnyView(EmptyView())
    }
}

