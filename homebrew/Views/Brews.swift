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
    @State var refreshId = UUID()
    
    @State var showForm = false
    var body: some View {
        ZStack {
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
                Spacer().padding(.vertical, 50)
            }.listStyle(PlainListStyle())
            .navigationTitle("Brews")
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: NewBrewForm().onDisappear(){
                        self.refreshId = UUID()
                    }){
                        Image("carboy").colorInvert()
                            .font(.system(.largeTitle))
                            .frame(width: 67, height: 67)
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
        }.id(refreshId)
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
