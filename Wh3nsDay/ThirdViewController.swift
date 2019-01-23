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
    private var events2 = Array<[NSManagedObject]>() // called events 2 because i wrote events 2 as a test and it worked so we used it - dane
    private var scrollNumber = 0
    private var scrollCount = 0
    private var endI = 0
    
    func strToDate(dayString : String) -> Date{// creates date obj from a string
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(dayString)
        let date: Date = dateFormatterGet.date(from: dayString+" 00:00:00")!
        return date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events2 = getEventDay(n: currentDateInString) // fills array with all events - h
        events2 = filter(eventsFull:events2, day: strToDate(dayString : currentDateInString)) // filters array to just the one day - h
        if(events2.count > 6){ //one page fits 7 events and if there are more then one can swipe up to see them.
            endI = 6 // end i is the end index of events that will be shown on a given page
        } else { endI = events2.count - 1}
        setup(startI: 0)
        // setup(startI: 7, endI: 23)
    }
    
    func filter(eventsFull: Array<[NSManagedObject]>, day : Date) -> Array<[NSManagedObject]> {
        let eventsFull = eventsFull
        var i : Int = 0
        var e = eventsFull
        for a in eventsFull{
            if ((((a[0].value(forKey: "startDate")) as! Date) < day) || (((a[0].value(forKey: "startDate")) as! Date) > day.addingTimeInterval(86400))){ // filters out events not in certain day - h
                e.remove(at: i)
                i-=1
            }
            i+=1
        }
        return e
    }
    
    @IBAction func swipeUp(_ sender: Any) { // allows user to swipe up to see more events if there are more than 7 events in that day - d
        scrollCount = scrollCount + 1 // count keeps track of what page/ scroll the user is on - d
        if(7 * scrollCount  >= events2.count){ // if there are no more events to scroll to then it will end method - d
            scrollCount = scrollCount - 1
            return
        }
        setup(startI: 7 * scrollCount) // runs setup with a new start index
    }
    @IBAction func swipeDown(_ sender: Any) { // same as swipe up but checks if one can continue swiping down - d
        scrollCount = scrollCount - 1
        if(scrollCount < 0){
           scrollCount = scrollCount + 1
            return
        }
        setup(startI: 7 * scrollCount)
    }
    
    public func setCurrentDateInString(d: String){ // mutator method called by previous view controller so we know what date/ events we need to show - d
        currentDateInString = d
    }
    
    func setup(startI: Int){ // sets up the events from a start index
        endI = (events2.count) - (events2.count - (scrollCount * 7)) - 2 // calculates what the End index should be depending on the length of the array
        if(events2.count - endI > 6){
            endI = 6 + scrollCount * 7
        }else{
            endI = events2.count % 7 + scrollCount * 7 - 1
        }
        view.subviews.forEach({ $0.removeFromSuperview() }) // clears everything
        setBackButton() // creates back button
        setDateLabel() // creates date label
        var div = endI - startI
        if(div < 2){ // div is a factor in how spaced the events labels are - d
            div = 2
        }
        
        let yDifference = (Int(UIScreen.main.bounds.height) - 250) / div // how far the lables are spaced - d
        var i = endI
        if (endI > events2.count - 1){ // prevents any out of bounds - d
            i = events2.count - 1
        }
        
        while i >= startI {     // creates label of event - d
            let eventLabel = UILabel()
            eventLabel.frame = CGRect(x: 80, y: 150
                + (yDifference * (i % 7)), width: 300, height: 30)
            let name = String(events2[i][0].value(forKey: "name") as! String) //pulls from database and gets startDate - h
            let df = DateFormatter()// gets startdate as a time - d
            df.dateFormat = "hh:mm:ss"
            let start = df.string(from: (events2[i][0].value(forKey: "startDate") as! Date)) //pulls from database and gets endDate - h
            df.dateFormat = "yyyy-MM-dd hh:mm:ss" // gets end date as a date and time - d
            let end = df.string(from: (events2[i][0].value(forKey: "endDate") as! Date))
            print(end)
            setStartAndEndTimes(str: "Start: " + start, yPosition: 150 // calls a method that sets up the start time label -d
                + (yDifference * (i % 7)) - 15)
            setStartAndEndTimes(str: "End: " + end, yPosition: 150 // sets up end time label
                + (yDifference * (i % 7)) + 15)
            eventLabel.text = String( "        " + name) // gives space for start and end time labels and sets name -d
            //print(eventLabel.text)
            
            eventLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
            eventLabel.textColor = UIColor.blue
            eventLabel.isHighlighted = false
            eventLabel.isUserInteractionEnabled = true
            eventLabel.isEnabled = true
            eventLabel.numberOfLines = 0
            eventLabel.adjustsFontSizeToFitWidth = true
            eventLabel.baselineAdjustment = UIBaselineAdjustment.alignCenters
            self.view.addSubview(eventLabel) // adds label to viewcontrolller
            createDeleteButton(i: i % 7, yDifference: yDifference) // creates a delete button that corresponds with the right label - d
            
            i = i - 1
        }
    }
    func setStartAndEndTimes(str: String, yPosition: Int){ // sets up label
        let label = UILabel()
        label.frame = CGRect(x: 20, y: yPosition, width: 90, height: 30)
        label.text = String(str)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        label.textColor = UIColor.blue
        label.isHighlighted = false
        label.isUserInteractionEnabled = true
        label.isEnabled = true
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = UIBaselineAdjustment.alignCenters
        self.view.addSubview(label)
    }
    func setBackButton(){ // creates back button
        let btn = UIButton(type: .custom)
        btn.frame = .init(x: 25, y: 60, width: 60, height: 20)
        btn.setTitle("Back", for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.layer.masksToBounds = true
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(backButton(Back: )), for: .touchUpInside)
    }
    @objc func backButton(Back: Int){ // this method is called when the previously made back button is pressed
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "CalView") as! SecondViewController
        self.present(homeView, animated: false, completion: nil)
    }
    func setDateLabel(){
        let dayLabel = UILabel()
        dayLabel.frame = CGRect(x: 207, y: 75, width: 500, height: 30)
        dayLabel.center.x = self.view.center.x
        dayLabel.text = currentDateInString
        dayLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 26)
        dayLabel.textColor = UIColor.blue
        dayLabel.textAlignment = NSTextAlignment.center
        dayLabel.center.x = dayLabel.center.x - 2
        dayLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        //dayLabel.highlightedTextColor = UIColor.green
        dayLabel.isHighlighted = false
        dayLabel.isUserInteractionEnabled = true
        dayLabel.isEnabled = true
        dayLabel.numberOfLines = 0
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.baselineAdjustment = UIBaselineAdjustment.alignCenters
        self.view.addSubview(dayLabel)
    }
    
    func createDeleteButton(i: Int, yDifference: Int){ // creates delete button based on what label it will delete
        let btn = UIButton(type: .custom)
        btn.frame = .init(x: 370, y: 155
            + (yDifference * (i % 7)), width: 20, height: 20)
        btn.setTitle("-", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.layer.masksToBounds = true
        self.view.addSubview(btn)
        addTarget(btn: btn, i: i) // unfortunatly when adding a target, u can not pass an argument so i have to check what index it is at with lots of if satements and then call an individual method based on that
    }
    
    func addTarget(btn: UIButton, i: Int){ // makes proper tagret for each delete button by checking the index it sould refer to
        if(i == 0){
            btn.addTarget(self, action: #selector(delete0(delete: )), for: .touchUpInside)
        }else if(i == 1){
            btn.addTarget(self, action: #selector(delete1(delete: )), for: .touchUpInside)
        }else if(i == 2){
            btn.addTarget(self, action: #selector(delete2(delete: )), for: .touchUpInside)
        }else if(i == 3){
            btn.addTarget(self, action: #selector(delete3(delete: )), for: .touchUpInside)
        }else if(i == 4){
            btn.addTarget(self, action: #selector(delete4(delete: )), for: .touchUpInside)
        }else if(i == 5){
            btn.addTarget(self, action: #selector(delete5(delete: )), for: .touchUpInside)
        }else if(i == 6){
            btn.addTarget(self, action: #selector(delete6(delete: )), for: .touchUpInside)
        }
    }
    // there methods delete an event based on the button that was pushed, there are 7 methods because there is a max of 7 events per swipe page.
    @objc func delete0(delete: Int){
        deleteEventByName(event: events2[scrollCount * 7 + 0][0] )
        events2.remove(at: scrollCount * 7 + 0 )
        if(events2.count == 0){
            endI = 0
            setup(startI: 0)
            return
        }
        if(scrollCount * 7 - endI == 0){
            scrollCount = scrollCount - 1
            if(scrollCount < 0){
                scrollCount = scrollCount + 1
                return
            }
        }
            setup(startI: 7 * scrollCount)
    }
    
    @objc func delete1(delete: NSManagedObject){
        deleteEventByName(event: events2[scrollCount * 7 + 1][0])
        events2.remove(at: scrollCount * 7 + 1 )
        setup(startI: scrollCount * 7)
    }
    
    @objc func delete2(delete: NSManagedObject){
        deleteEventByName(event: events2[scrollCount * 7 + 2][0])
        events2.remove(at: scrollCount * 7 + 2 )
        setup(startI: scrollCount * 7)
    }
    
    @objc func delete3(delete: NSManagedObject){
        deleteEventByName(event: events2[scrollCount * 7 + 3][0])
        events2.remove(at: scrollCount * 7 + 3 )
        setup(startI: scrollCount * 7)
    }
    
    @objc func delete4(delete: NSManagedObject){
        deleteEventByName(event: events2[scrollCount * 7 + 4][0])
        events2.remove(at: scrollCount * 7 + 4 )
        setup(startI: scrollCount * 7)
    }
    
    @objc func delete5(delete: NSManagedObject){
        deleteEventByName(event: events2[scrollCount * 7 + 5][0])
        events2.remove(at: scrollCount * 7 + 5 )
        setup(startI: scrollCount * 7)
    }
    
    @objc func delete6(delete: NSManagedObject){
        deleteEventByName(event: events2[scrollCount * 7 + 6][0])
        events2.remove(at: scrollCount * 7 + 6 )
        setup(startI: scrollCount * 7)
    }
    


    func getEventDay(n: String) -> Array<[NSManagedObject]> { // gets the event from the string dane passes to me - h
        var eventDay : Array<[NSManagedObject]> = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity") // pulls from database - h
        let context = AppDelegate.getContext()
        let sort = NSSortDescriptor(key: "startDate", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.returnsObjectsAsFaults = false
        //Add each event one by one that fits the filter in order - h
        do {
            let result = try context.fetch(fetchRequest)
            //("end6")
            for data in result as! [NSManagedObject] {
                eventDay.append([data])
            }
            
        } catch {
            print("Failed")
        }
        
        return eventDay
    }
    
    func deleteEventByName(event:NSManagedObject){
        
            //Creates a retchRequest which has access to all events in the database -h
            let context = AppDelegate.getContext()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        
            let result = try? context.fetch(fetchRequest)
            let resultData = result as! [Entity]
            
            for object in resultData {
                if(object == event){
                    context.delete(object)
                }
            }
        
            //Save the channges made to the file - h
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
