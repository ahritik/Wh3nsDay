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
    public var currentDateInString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func getEventDay(n: String) -> Array<[NSManagedObject]> {
        
        var eventDay : Array<[NSManagedObject]> = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        
        //filters the events for the day
        fetchRequest.predicate = NSPredicate(format: "date = %@", n)
        let context = AppDelegate.getContext()
        
        //sort the objects
        let sort = NSSortDescriptor(key: "startDate", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.returnsObjectsAsFaults = false
        
        //Add each event one by one that fits the filter in order
        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                eventDay.append(data.value(forKey: "name") as! [NSManagedObject])
            }
            
        } catch {
            print("Failed")
        }
        return eventDay
    }
    
    func deleteEvent(name:String){
            //Creates a retchRequest which has access to all events in the database
            let context = AppDelegate.getContext()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
            fetchRequest.predicate = NSPredicate(format: "date = %@", name)
        
            let result = try? context.fetch(fetchRequest)
            let resultData = result as! [Entity]
            
            for object in resultData {
                context.delete(object)
            }
        
            //Save the channges made to the file
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                print("Wack error is \(error)")
            }
    }

    
}
