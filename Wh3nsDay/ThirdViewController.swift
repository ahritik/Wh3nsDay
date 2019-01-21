//
//  ThirdViewController.swift
//  Wh3nsDay
//
//  Created by Hritik Arasu on 1/19/19.
//  Copyright © 2019 Hritik Arasu. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func getEventDay(n: String) -> Array<NSManagedObject> {
        
        var eventDay : Array<[NSManagedObject]> = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "date = %@", n)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        fetchRequest.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                eventDay.append(data.value(forKey: "name"))
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    func deleteEvent(name:String){
        func deleteRecords() -> Void {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
            fetchRequest.predicate = NSPredicate(format: "date = %@", name)

            let result = try? context.fetch(fetchRequest)
            let resultData = result as! [Entity]
            
            for object in resultData {
                context.delete(object)
            }
            
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
        }
    }
    
    
}
