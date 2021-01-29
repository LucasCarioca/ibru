//
//  BrewDetail.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

struct BrewDetail: View {
    var brew: Brew
    @State var updated = Date()
    @State var popup = false
    @State var showEditForm = false
    @State var showReadingForm = false
    @State var showBottleForm = false
    var body: some View {
        VStack {
//            Text("Last updated: \(updated, formatter: brewDateFormatter)")
//                .font(.callout)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal)
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
                        GravityReading(date: reading.date ?? Date(), gravity: reading.gravity, originalGravity: brew.originalGravity)
                    }.onDelete(perform: deleteItems)
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            reset()
                            showBottleForm = true
                            popup = true
                        }){
                            Image("bottle").colorInvert()
                                .font(.system(.largeTitle))
                                .frame(width: 67, height: 67)
                        }
                        .background(Color.accentColor)
                        .cornerRadius(50)
                        .padding(.vertical)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                        Button(action: {
                            reset()
                            showReadingForm = true
                            popup = true
                        }){
                            Image("testtube").colorInvert()
                                .font(.system(.largeTitle))
                                .frame(width: 67, height: 67)
                        }
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
            }
        }
        .navigationTitle(brew.name ?? "Missing name")
        .navigationBarItems(trailing: Button(action: {
            reset()
            showEditForm = true
            popup = true
        }){
            HStack {
                Image(systemName: "square.and.pencil")
                Text("Edit")
            }
        })
        .overlay(NewBottleRecordForm(shown: $showBottleForm, brew: brew) {
            showBottleForm = false
            updated = Date()
        })
        .overlay(NewReadingForm(shown: $showReadingForm, brew: brew) {
            showReadingForm = false
            updated = Date()
        })
        .overlay(UpdateBrewForm(shown: $showEditForm, brew: brew) {
            showEditForm = false
            updated = Date()
        })
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
                updated = Date()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func showBottlingInfo() -> AnyView {
        if let bottle = brew.bottles {
            return AnyView(HStack {
                Image("bottle").padding().padding(.horizontal, 7)
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
                }
            })
        }
        return AnyView(EmptyView())
    }
    private func reset() {
        showReadingForm = false
        showEditForm = false
        showBottleForm = false
    }
}

private let brewDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
