//
//  CollectionTile.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import SwiftUI
import QuickComponents

struct CollectionTile: View {
    var brew: Brew
    var onChange: () -> Void
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(brew.name ?? "missing name")
                        .font(.title2)
                        .fontWeight(.heavy)
                        
                    Spacer()
                }.padding()
                getBottleCount()
                InfoLabel(label: "Age", value: getTimeText())
                getProgressBar()
            }
            Spacer()
            VStack {
                Button(action: {print("adding"); addOrRemoveBottle(amount: 1)}) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
                    .buttonStyle(BorderlessButtonStyle())
                    .contentShape(Rectangle())
                Spacer()
                Button(action: {print("removing"); addOrRemoveBottle(amount: -1)}) {
                    Image(systemName: "minus.circle.fill")
                        .imageScale(.large)
                }
                    .buttonStyle(BorderlessButtonStyle())
                    .contentShape(Rectangle())
            }.padding()
        }
    }
    
    func getTimeText() -> String {
        var brewAge = getAge(of: brew, fromBottlingDate: true)
        var label = "Days"
        if brewAge >= 30 {
            brewAge = brewAge / 30
            label = "Months"
        }
        return "\(String(format: "%.1f", brewAge)) \(label)"
    }
    
    func getProgressBar() -> BarView {
        var age = getAge(of: brew, fromBottlingDate: true)
        if age < 30 {
            age = 30
        } else if age >= 365 {
            age = 365
        }
        return BarView(value: CGFloat(age), max: 365, showLabel: nil, color: .accentColor)
    }
    
    func getBottleCount() -> AnyView {
        if getStage(of: brew) == .bottled {
            return AnyView(
                InfoLabel(label: "Bottle Count", value: "\(brew.bottles?.count ?? 0)")
            )
        }
        return AnyView(EmptyView())
    }
    
    func addOrRemoveBottle(amount: Int16 ) {
        if let bottles = brew.bottles {
            bottles.count = bottles.count + amount
            do {
                try bottles.managedObjectContext!.save()
                print("saved: \(bottles.count + amount)")
                onChange()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
