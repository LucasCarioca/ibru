//
// Created by Lucas Desouza on 11/22/21.
//

import Foundation
import CoreData

class BrewBuilder {
    var brew: Brew

    init(context: NSManagedObjectContext) {
        brew = Brew(context: context)
    }

    func withDetails(name: String, date: String, og: Double) -> BrewBuilder {
        brew.startDate = brewDateFormatter.date(from: date)
        brew.name = name
        brew.originalGravity = og
        return self
    }

    func withSecondary(date: String, gravity: Double) -> BrewBuilder {
        let secondary = Secondary(context: brew.managedObjectContext!)
        secondary.date = brewDateFormatter.date(from: date)
        secondary.gravity = gravity
        brew.secondary = secondary
        return self
    }

    func withBottle(date: String, fg: Double, count: Int16) -> BrewBuilder {
        let bottles = Bottle(context: brew.managedObjectContext!)
        bottles.date = brewDateFormatter.date(from: date)
        bottles.finalGravity = fg
        bottles.count = count
        brew.bottles = bottles
        return self
    }

    func withReading(date: String, gravity: Double) -> BrewBuilder {
        let reading = Reading(context: brew.managedObjectContext!)
        reading.date = brewDateFormatter.date(from: date)
        reading.gravity = gravity
        brew.addToReadings(reading)
        return self
    }

    func build() -> Brew {
        brew
    }
}