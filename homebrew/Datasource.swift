//
//  Datasource.swift
//  iBru
//
//  Created by Lucas Desouza on 11/22/21.
//

import Foundation
import CoreData

class Datasource {
    private static let CONTAINER_NAME = "homebrew"
    private let container: NSPersistentCloudKitContainer

    init(inMemory: Bool) {
        if inMemory {
            container = Datasource.inMemory()
        } else {
            container = Datasource.cloud()
        }
    }

    private static func cloud() -> NSPersistentCloudKitContainer {
        let container = NSPersistentCloudKitContainer(name: CONTAINER_NAME)
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }

    private static func inMemory() -> NSPersistentCloudKitContainer {
        let container = NSPersistentCloudKitContainer(name: CONTAINER_NAME)
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        let viewContext = container.viewContext
        let brew1 = BrewBuilder(context: viewContext)
                .withDetails(name: "Traditional Mead", date: "01/17/2020", og: 1.11)
                .withSecondary(date: "03/01/2020", gravity: 1.00)
                .withBottle(date: "04/18/2020", fg: 1.00, count: 20)
                .build()
        let _ = BrewBuilder(context: viewContext)
                .withDetails(name: "IPA Beer", date: "06/12/2021", og: 1.052)
                .withBottle(date: "07/01/2021", fg: 1.010, count: 50)
                .build()
        let _ = BrewBuilder(context: viewContext)
                .withDetails(name: "Red Wine", date: "01/30/2021", og: 1.080)
                .withSecondary(date: "03/15/2021", gravity: 0.998)
                .withBottle(date: "04/12/2021", fg: 0.998, count: 20)
                .build()
        let _ = BrewBuilder(context: viewContext)
                .withDetails(name: "Blueberry Mead", date: "06/21/2021", og: 1.115)
                .build()
        let _ = BrewBuilder(context: viewContext)
                .withDetails(name: "Strawberry Mead", date: "07/13/2021", og: 1.103)
                .build()
        let _ = BrewBuilder(context: viewContext)
                .withDetails(name: "Lager Beer", date: "09/13/2021", og: 1.048)
                .build()
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return container
    }

    public func getContainer() -> NSPersistentCloudKitContainer {
        return container
    }
}
