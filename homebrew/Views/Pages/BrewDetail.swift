//
//  BrewDetail.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

struct BrewDetail: View {
    var brew: Brew
    @State private var refreshID = UUID()
    @State private var showEditView = false
    @State private var showEditBottlesView = false
    var body: some View {
        VStack {
            Text(brew.comment ?? "")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Image("carboy").padding()
                VStack {
                    Text("Primary Fermentation").bold().font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("OG: \(brew.originalGravity)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Potential ABV: \((brew.originalGravity-1)*131.25)%")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Start date: \(brew.startDate ?? Date(), formatter: brewDateFormatter)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    showAge().font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                NavigationLink(
                    destination: UpdateBrewForm(brew: brew).onDisappear(perform: refresh),
                    isActive: $showEditView) { Button(action: {self.showEditView = true}) {
                    Image(systemName: "square.and.pencil").padding()
                }}
            }
            showSecondaryInfo().padding(.vertical)
            showBottlingInfo().padding(.vertical)
            Spacer()
            HStack {
                Text("Readings")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }.padding()
            ZStack {
                List {
                    ForEach(getReadingList(), id: \.self) { reading in
                        NavigationLink(destination: UpdateReadingForm(reading: reading).onDisappear(perform: refresh)){
                            GravityReading(date: reading.date ?? Date(), gravity: reading.gravity, originalGravity: brew.originalGravity)
                        }
                    }.onDelete(perform: deleteItems)
                    Spacer().padding(.vertical, 50)
                }
                showButtons()
            }
        }
        .navigationTitle(brew.name ?? "Missing name")
        .id(refreshID)
    }
    
    private func getReadingList() -> [Reading] {
        let set = brew.readings! as? Set<Reading> ?? []
        return set.sorted {
            $0.date! < $1.date!
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            print(offsets)
            let readingList = getReadingList()
            offsets.map { readingList[$0] }.forEach(brew.managedObjectContext!.delete)
            do {
                try brew.managedObjectContext!.save()
                refresh()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func showAge(fromBottlingDate: Bool = false, fromSecondary: Bool = false) -> AnyView {
        var brewAge = getAge(of: brew, fromBottlingDate: fromBottlingDate, fromSecondary: fromSecondary)
        var label = "days"
        if brewAge >= 30 {
            label = "months"
            brewAge = brewAge/30
        }
        return AnyView(Text("\(String(format: "%.1f", brewAge)) \(label)"))
    }
    
    private func showButtons() -> AnyView {
        if let _ = brew.bottles {
            return AnyView(EmptyView())
        }
        return AnyView(VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: NewReadingForm(brew: brew).onDisappear(perform: refresh)){
                    Image("testtube").colorInvert()
                        .font(.system(.largeTitle))
                        .frame(width: 67, height: 67)
                        .background(Color.accentColor)
                        .cornerRadius(50)
                        .padding(.vertical)
                        .padding(.trailing, 12)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                }
            }
        })
    }
    
    private func showBottlingInfo() -> AnyView {
        if let bottle = brew.bottles {
            return AnyView(HStack {
                Image("bottle").padding()
                VStack {
                    Text("Bottled").bold().font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Bottle Count: \(bottle.count)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Final gravity: \(bottle.finalGravity)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Final ABV: \((brew.originalGravity-bottle.finalGravity)*131.25)%")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("End Date: \(bottle.date ?? Date(), formatter: brewDateFormatter)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    showAge(fromBottlingDate: true).font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                NavigationLink(
                    destination: UpdateBottleRecord(bottle: bottle).onDisappear(perform: refresh),
                    isActive: $showEditBottlesView) { Button(action: {self.showEditBottlesView = true}) {
                    Image(systemName: "square.and.pencil").padding()
                }}
            })
        }
        return AnyView(NavigationLink(destination: NewBottleRecordForm(brew: brew).onDisappear(perform: refresh)) {
            HStack {
                Image(systemName: "plus").padding(.leading)
                Text("Bottling")
                    .fontWeight(.bold)
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        })
    }
    
    private func showSecondaryInfo() -> AnyView {
        if let secondary = brew.secondary {
            return AnyView(HStack {
                Image("carboy").padding()
                VStack {
                    Text("Secondary Fermentation").font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Current gravity: \(secondary.gravity)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Current ABV: \((brew.originalGravity-secondary.gravity)*131.25)%")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Start date: \(secondary.date ?? Date(), formatter: brewDateFormatter)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    showAge(fromSecondary: true).font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            })
        } else if let _ = brew.bottles {
            return AnyView(EmptyView())
        }
        return AnyView(NavigationLink(destination: NewSecondaryRecord(brew: brew).onDisappear(perform: refresh)) {
            HStack {
                Image(systemName: "plus").padding(.leading)
                Text("Secondary")
                    .fontWeight(.bold)
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        })
    }
    
    private func refresh() {
        refreshID = UUID()
    }
}
