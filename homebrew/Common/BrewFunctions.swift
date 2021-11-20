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
    offsets.map {
        brews[$0]
    }.forEach(context.delete)

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
        if let secondary = brew.secondary {
            to = secondary.date ?? Date()
        } else if let bottle = brew.bottles {
            to = bottle.date ?? Date()
        }
    }
    let brewAge = to.timeIntervalSince(from ?? Date()) / 86400
    return brewAge
}

func getCurrentABV(of brew: Brew) -> Double {
    let fg = getCurrentGravity(of: brew)
    let og = brew.originalGravity
    return (og - fg) * 131.25
}

func getCurrentGravity(of brew: Brew) -> Double {
    if let bottles = brew.bottles {
        return bottles.finalGravity
    } else if let secondary = brew.secondary {
        return secondary.gravity
    } else if let reading = getLatestReading(of: brew) {
        return reading.gravity
    }
    return brew.originalGravity
}

func getLatestReading(of brew: Brew) -> Reading? {
    if let readings = brew.readings {
        var readingsList = readings.allObjects as! [Reading]
        readingsList.sort(by: { $0.date!.compare($1.date!) == .orderedDescending })
        if readingsList.count > 0 {
            return readingsList[0]
        }
    }
    return nil
}


