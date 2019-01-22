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
    private var currentDateInString = ""
    private var events = Array<[NSManagedObject]>()
    private var events2 = [Int]()
    private var scrollNumber = 0
    private var scrollCount = 0
    private var endI = 0
    func addup(e: Int){
        var i = 0
        while i < e{
            events2.append(i)
            i = i + 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentDateInString)
        addup(e: 43)
       // scrollNumber = Int(events2 / 12)
       // events = getEventDay(n: currentDateInString)
        //print(events[0])
        // Do any additional setup after loading the view, typically from a nib.
        if(events2.count > 11){
            endI = 11
        } else { endI = events2.count - 1}
        setup(startI: 0, endI: endI)
        // setup(startI: 12, endI: 23)
    }
    @IBAction func swipeUp(_ sender: Any) {
        scrollCount = scrollCount + 1
        print(scrollCount)
        if(12 * scrollCount  > events2.count){
            print("done")
            scrollCount = scrollCount - 1
            return
        }
        
        endI = (events2.count) - (events2.count - (scrollCount * 12)) - 2
        print("________________" + String(endI))
        if(events2.count - endI > 11){
            endI = 11 + scrollCount * 12
        }else{
            endI = events2.count % 12 + scrollCount * 12 - 1
        }
        print(endI)
        
        setup(startI: 12 * scrollCount, endI: endI)
    }
    @IBAction func swipeDown(_ sender: Any) {
        scrollCount = scrollCount - 1
        if(scrollCount < 0){
           scrollCount = scrollCount + 1
            return
        }
        endI = (events2.count) - (events2.count - (scrollCount * 12)) - 2
        print("________________" + String(endI))
        if(events2.count - endI > 11){
            endI = 11 + scrollCount * 12
        }else{
            endI = events2.count % 12 + scrollCount * 12 - 1
        }
        setup(startI: 12 * scrollCount, endI: endI)
    }
    public func setCurrentDateInString(d: String){
        currentDateInString = d
    }
    func setup(startI: Int, endI: Int){
        view.subviews.forEach({ $0.removeFromSuperview() })
        let yDifference = (Int(UIScreen.main.bounds.height) - 250) / (endI - startI)
        var i = endI
        
        while i >= startI {
            let eventLabel = UILabel()
            eventLabel.frame = CGRect(x: 207, y: 150
                + (yDifference * (i % 12)), width: 300, height: 30)
            eventLabel.center.x = self.view.center.x
            print(i)
            eventLabel.text = String(events2[i])
            eventLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 38)
            eventLabel.textColor = UIColor.blue
            eventLabel.textAlignment = NSTextAlignment.center
            eventLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            eventLabel.isHighlighted = false
            eventLabel.isUserInteractionEnabled = true
            eventLabel.isEnabled = true
            eventLabel.numberOfLines = 0
            eventLabel.adjustsFontSizeToFitWidth = true
            eventLabel.baselineAdjustment = UIBaselineAdjustment.alignCenters
            self.view.addSubview(eventLabel)
            
            i = i - 1
        }
    }
    
    func getEventDay(n: String) -> Array<[NSManagedObject]> {
        
        var eventDay : Array<[NSManagedObject]> = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        
        //filters the events for the day
        
        fetchRequest.predicate = NSPredicate(format: "date = %@", n)
        print("end")
        let context = AppDelegate.getContext()
        print("end2")
        //sort the objects
        let sort = NSSortDescriptor(key: "startDate", ascending: true)
        print("end3")
        fetchRequest.sortDescriptors = [sort]
        print("end4")
        fetchRequest.returnsObjectsAsFaults = false
        print("end5")
        
        //Add each event one by one that fits the filter in order
        do {
            let result = try context.fetch(fetchRequest)
            print("end6")
            for data in result as! [NSManagedObject] {
                eventDay.append(data.value(forKey: "name") as! [NSManagedObject])
                print("end7")
            }
            
        } catch {
            print("Failed")
        }
        
        return eventDay
    }
    
    func deleteAllEventsInDate(name:String){
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
