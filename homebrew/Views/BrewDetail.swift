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
    @State var showReadingForm = true
    @State var showBottleForm = false
    var body: some View {
        VStack {
//            Text("Last updated: \(updated, formatter: brewDateFormatter)")
//                .font(.callout)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal)
            
            Text("Original gravity: \(brew.originalGravity)")
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text("Potential ABV: \((brew.originalGravity-1)*131.25)%")
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Text("Brew start date: \(brew.startDate ?? Date(), formatter: brewDateFormatter)")
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            showBottlingInfo().padding(.vertical)
            Spacer()
            HStack {
                Text("Readings")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }.padding()
            .sheet(isPresented: $popup) {
                if showBottleForm {
                    NewBottleRecordForm(brew: brew) {
                        showBottleForm = false
                        popup = false
                        updated = Date()
                    }
                } else if showReadingForm {
                    NewReadingForm(brew: brew) {
                        showReadingForm = false
                        popup = false
                        updated = Date()
                    }
                }
            }
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
                            showReadingForm = true
                            popup = true
                        }){
                            Text("+")
                                .font(.system(.largeTitle))
                                .frame(width: 67, height: 60)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 7)
                        }
                            .background(Color.accentColor)
                            .cornerRadius(38.5)
                            .padding()
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
            showBottleForm = true
            popup = true
        }){
            Text("Bottle")
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
            return AnyView(VStack {
                Text("FInal gravity: \(bottle.finalGravity)")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Final ABV: \((brew.originalGravity-bottle.finalGravity)*131.25)%")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Bottle date: \(bottle.date ?? Date(), formatter: brewDateFormatter)")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            })
        }
        return AnyView(EmptyView())
    }
}

private let brewDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
