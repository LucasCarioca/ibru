//
//  Brews.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import SwiftUI

struct Brews: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Brew.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Brew.startDate, ascending: false)],
        animation: .default)
    private var brews: FetchedResults<Brew>
    
    @State var showForm = false
    var body: some View {
        List {
            ForEach(brews) { brew in
                NavigationLink(destination: BrewDetail(brew: brew)) {
                    HStack {
                        Text(brew.name ?? "Name missing")
                        Spacer()
                        Text("\(brew.startDate!, formatter: brewDateFormatter)")
                    }
                }
            }.onDelete(perform: deleteItems)
        }.listStyle(PlainListStyle())
        .sheet(isPresented: $showForm) {
            NewBrewForm() {
                showForm = false
            }
        }
        .navigationTitle("Brews")
        .navigationBarItems(trailing: Button(action: {
            showForm = true
        }){
            Image(systemName: "plus")
        })
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { brews[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let brewDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct Brews_Previews: PreviewProvider {
    static var previews: some View {
        Brews()
    }
}
