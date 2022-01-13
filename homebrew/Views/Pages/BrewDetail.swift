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
    @State private var editNotes = false
    @State private var showEditBottlesView = false
    @State private var notes = ""

    var body: some View {
        List {
            if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                NavigationLink(destination: BrewCategoryEditor(onSave: updateCategory, currentCategory: BrewCategory(rawValue: brew.category!) ?? .ALL)) {
                    Text("Category").badge(brew.category ?? "None")
                }
            }
            Section {
                HStack {
                    Image("carboy").padding().frame(width: 50)
                    NavigationLink(
                            destination: UpdateBrewForm(brew: brew).onDisappear(perform: refresh),
                            isActive: $showEditView) {
                        VStack {
                            Text("Primary Fermentation").bold().font(.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            Text("OG: \(String(format: "%.3f", brew.originalGravity))")
                                    .font(.callout)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Potential ABV: \(String(format: "%.2f", (brew.originalGravity - 1) * 131.25))%")
                                    .font(.callout)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Start date: \(brew.startDate ?? Date(), formatter: brewDateFormatter)")
                                    .font(.callout)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            showAge().font(.callout)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                    showSecondaryInfo().padding(.vertical)
                }
                showBottlingInfo().padding(.vertical)
            }

            Section {
                NavigationLink(destination: Readings(brew: brew).onDisappear(perform: refresh)) {
                    HStack {
                        Image(systemName: "square.and.pencil").padding(.leading)
                        Text("Readings")
                                .fontWeight(.bold)
                                .frame(alignment: .leading)
                        Spacer()
                    }.padding(.vertical).badge(brew.readings?.count ?? 0)
                }
            }

            Section {
                NavigationLink(destination: BrewTextEditor(title: "Description", text: brew.comment ?? "", onSave: updateComment)) {
                    brew.comment != nil ? AnyView(VStack {
                        HStack {
                            Image(systemName: "square.and.pencil")
                                    .padding(.leading)
                            Text("Description")
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                            Spacer()
                        }.padding(.vertical)
                        Text(brew.comment ?? "")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                    }) : AnyView(HStack {
                        Image(systemName: "square.and.pencil")
                                .padding(.leading)
                        Text("Description")
                                .fontWeight(.bold)
                                .frame(alignment: .leading)
                        Spacer()
                    }.padding(.vertical))
                }.buttonStyle(.plain)
                if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                    NavigationLink(destination: BrewTextEditor(title: "Notes", text: brew.notes ?? "", onSave: updateNotes)) {
                        brew.notes != nil ? AnyView(VStack {
                            HStack {
                                Image(systemName: "square.and.pencil")
                                        .padding(.leading)
                                Text("Notes")
                                        .fontWeight(.bold)
                                        .frame(alignment: .leading)
                                Spacer()
                            }.padding(.vertical)
                            Text(brew.notes ?? "")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                        }) : AnyView(HStack {
                            Image(systemName: "square.and.pencil")
                                    .padding(.leading)
                            Text("Notes")
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                            Spacer()
                        }.padding(.vertical))
                    }.buttonStyle(.plain)
                }
            }
        }
                .navigationTitle(brew.name ?? "Missing name")
                .id(refreshID)

    }

    private func updateNotes(notes: String) {
        brew.notes = notes
        do {
            try brew.managedObjectContext?.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func updateCategory(category: BrewCategory) {
        brew.category = category.rawValue
        do {
            try brew.managedObjectContext?.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func updateComment(comment: String) {
        brew.comment = comment
        do {
            try brew.managedObjectContext?.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func showAge(fromBottlingDate: Bool = false, fromSecondary: Bool = false) -> AnyView {
        var brewAge = getAge(of: brew, fromBottlingDate: fromBottlingDate, fromSecondary: fromSecondary)
        var label = "days"
        if brewAge >= 30 {
            label = "months"
            brewAge = brewAge / 30
        }
        return AnyView(Text("\(String(format: "%.1f", brewAge)) \(label)"))
    }

    private func showBottlingInfo() -> AnyView {
        if let bottle = brew.bottles {
            return AnyView(NavigationLink(
                    destination: UpdateBottleRecord(bottle: bottle).onDisappear(perform: refresh),
                    isActive: $showEditBottlesView) {
                HStack {

                    Image("bottle").padding().frame(width: 50)
                    VStack {
                        Text("Bottled").bold().font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                            Text("Bottle Count: \(bottle.count)")
                                    .font(.callout)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Text("Final gravity: \(String(format: "%.3f", bottle.finalGravity))")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Final ABV: \(String(format: "%.2f", (brew.originalGravity - bottle.finalGravity) * 131.25))%")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        Text("End Date: \(bottle.date ?? Date(), formatter: brewDateFormatter)")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        showAge(fromBottlingDate: true).font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                    }


                }
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
            return AnyView(NavigationLink(destination: UpdateSecondaryRecord(secondary: secondary).onDisappear(perform: refresh)) {
                HStack {
                    Image("carboy").padding().frame(width: 50)
                    VStack {
                        Text("Secondary Fermentation").bold().font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Current gravity: \(String(format: "%.3f", secondary.gravity))")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Current ABV: \(String(format: "%.2f", (brew.originalGravity - secondary.gravity) * 131.25))%")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Start date: \(secondary.date ?? Date(), formatter: brewDateFormatter)")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        showAge(fromSecondary: true).font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                    }
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
