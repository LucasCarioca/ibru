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
                NavigationLink(destination: BrewCategoryEditor(onSave: updateCategory, currentCategory: BrewCategory(rawValue: brew.category ?? "ALL") ?? .ALL )) {
                    Text("Category").badge(brew.category ?? "None")
                }
            }
            Section {
                HStack {
                    Image("carboy").padding().frame(width: 50)
                    NavigationLink(
                            destination: UpdateBrewForm(brew: brew).onDisappear(perform: refresh),
                            isActive: $showEditView) {
                        PrimaryDetailView(brew: brew)
                    }
                }.padding(.vertical)
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

    private func showBottlingInfo() -> AnyView {
        if let bottle = brew.bottles {
            return AnyView(NavigationLink(
                    destination: UpdateBottleRecord(bottle: bottle).onDisappear(perform: refresh),
                    isActive: $showEditBottlesView) {
                HStack {
                    Image("bottle").padding().frame(width: 50)
                    BottleDetailView(brew: brew)
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
                    SecondaryDetailView(brew: brew)
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
