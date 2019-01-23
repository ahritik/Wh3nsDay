//
//  DataController.swift
//  Wh3nsDay
//
//  Created by Hritik Arasu on 1/19/19.
//  Copyright © 2019 Hritik Arasu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataController: NSObject { // uses NSObject to work with dates and time managment - h
    var managedObjectContext: NSManagedObjectContext?
    
    init(completionClosure: @escaping () -> ()) {
        let persistentContainer = NSPersistentContainer(name: "Wh3nsDay") // creates a container in core data with the name wh3nsday - h
        persistentContainer.loadPersistentStores() { (description, error) in // catchs error in loading
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }
    
}
