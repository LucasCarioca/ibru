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
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text("Stage: ")
                        .fontWeight(.bold)
                    getStageText()
                    Spacer()
                }
                HStack {
                    Text("Elapsed Time: ")
                        .fontWeight(.bold)
                    getTimeText()
                    Spacer()
                }
            }
        }
    }
    
    func getStageText() -> Text {
        let brewStage = getStage(of: brew)
        return Text(brewStage.rawValue)
    }
    
    func getTimeText() -> Text {
        
        var brewAge = getAge(of: brew)
        var label = "Days"
        if brewAge >= 30 {
            brewAge = brewAge / 30
            label = "Months"
        }
        return Text("\(String(format: "%.1f", brewAge)) \(label)")
    }
}
