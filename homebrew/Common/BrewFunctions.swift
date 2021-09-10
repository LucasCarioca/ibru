//
//  BrewFunctions.swift
//  iBru
//
//  Created by Lucas Desouza on 9/10/21.
//

import Foundation
import CoreData
import SwiftUI

func deleteBrew(offsets: IndexSet, brews: FetchedResults<Brew>, context: NSManagedObjectContext) {
    offsets.map { brews[$0] }.forEach(context.delete)

    do {
        try context.save()
    } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
}

func getAge(of brew: Brew, fromBottlingDate: Bool = false, fromSecondary: Bool = false) -> Double {
    var from = brew.startDate
    var to = Date()
    if fromBottlingDate {
        from = brew.bottles?.date
    } else if fromSecondary {
        from = brew.secondary?.date
        if let bottle = brew.bottles {
            to = bottle.date ?? Date()
        }
    } else {
        if let seconary = brew.secondary {
            to = seconary.date ?? Date()
        } else if let bottle = brew.bottles {
            to = bottle.date ?? Date()
        }
    }
    let brewAge = to.timeIntervalSince(from ?? Date()) / 86400
    return brewAge
}


