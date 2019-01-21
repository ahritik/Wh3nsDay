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

class DataController: NSObject {
    var managedObjectContext: NSManagedObjectContext?
    
    init(completionClosure: @escaping () -> ()) {
        let persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }
    
}
