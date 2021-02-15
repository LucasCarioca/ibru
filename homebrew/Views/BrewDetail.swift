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
    var body: some View {
        VStack {
            Text(brew.comment ?? "")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Image("carboy").padding()
                VStack {
                    Text("Original gravity: \(brew.originalGravity)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Potential ABV: \((brew.originalGravity-1)*131.25)%")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Brew start date: \(brew.startDate ?? Date(), formatter: brewDateFormatter)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    showDaysSinceBrew().font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
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
        .navigationBarItems(trailing: NavigationLink(destination: UpdateBrewForm(brew: brew).onDisappear(perform: refresh)){
            HStack {
                Image(systemName: "square.and.pencil")
                Text("Edit")
            }
        })
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
    
    private func showDaysSinceBrew() -> AnyView {
        if let _ = brew.bottles {
            return AnyView(EmptyView())
        }
        let brewAge = Date().timeIntervalSince(brew.startDate ?? Date()) / 86400
        return AnyView(Text("Fermenting for \(String(format: "%.1f", brewAge)) days"))
    }
    
    private func showButtons() -> AnyView {
        if let _ = brew.bottles {
            return AnyView(EmptyView())
        }
        return AnyView(VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: NewBottleRecordForm(brew: brew).onDisappear(perform: refresh)) {
                    Image("bottle").colorInvert()
                        .font(.system(.largeTitle))
                        .frame(width: 67, height: 67)
                        .background(Color.accentColor)
                        .cornerRadius(50)
                        .padding(.vertical)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                }
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
            let bottleAge = Date().timeIntervalSince(bottle.date ?? Date()) / 86400
            return AnyView(HStack {
                Image("bottle").padding()
                VStack {
                    Text("FInal gravity: \(bottle.finalGravity)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Final ABV: \((brew.originalGravity-bottle.finalGravity)*131.25)%")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Bottle date: \(bottle.date ?? Date(), formatter: brewDateFormatter)")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(String(format: "%.1f", bottleAge)) Days old")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            })
        }
        return AnyView(EmptyView())
    }
    
    private func refresh() {
        refreshID = UUID()
    }
}

private let brewDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
