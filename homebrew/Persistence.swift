//
//  Persistence.swift
//  homebrew
//
//  Created by Lucas Desouza on 1/26/21.
//

import CoreData



struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let brew1 = BrewBuilder(context: viewContext)
            .withDetails(name: "Traditional Mead", date: "01/17/2020", og: 1.11)
            .withSecondary(date: "03/01/2020", gravity: 1.00)
            .withBottle(date: "04/18/2020", fg: 1.00, count: 20)
            .build()
        let brew2 = BrewBuilder(context: viewContext)
            .withDetails(name: "IPA Beer", date: "06/12/2021", og: 1.052)
            .withBottle(date: "07/01/2021", fg: 1.010, count: 50)
            .build()
        let brew3 = BrewBuilder(context: viewContext)
            .withDetails(name: "Red Wine", date: "01/30/2021", og: 1.080)
            .withSecondary(date: "03/15/2021", gravity: 0.998)
            .withBottle(date: "04/12/2021", fg: 0.998, count: 20)
            .build()
        let brew4 = BrewBuilder(context: viewContext)
            .withDetails(name: "Blueberry Mead", date: "06/21/2021", og: 1.115)
            .build()
        let brew5 = BrewBuilder(context: viewContext)
            .withDetails(name: "Strawberry Mead", date: "07/13/2021", og: 1.103)
            .build()
        let brew6 = BrewBuilder(context: viewContext)
            .withDetails(name: "Lager Beer", date: "09/13/2021", og: 1.048)
            .build()
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "homebrew")
        container.viewContext.automaticallyMergesChangesFromParent = true
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

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
        return self.brew
    }
}


