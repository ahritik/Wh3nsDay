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
    private var events2 = Array<[NSManagedObject]>()
    private var scrollNumber = 0
    private var scrollCount = 0
    private var endI = 0
    func addup(e: Int){
        var i = 0
        while i < e{
           // events2.append(i)
            i = i + 1
        }
    }
    
    func strToDate(dayString : String) -> Date{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date: Date = dateFormatterGet.date(from: dayString+" 00:00:00")!
        return date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentDateInString)
        //addup(e: 21)
       // scrollNumber = Int(events2 / 12)
        events2 = getEventDay(n: currentDateInString)
        
        events2 = filter(eventsFull:events2, day: strToDate(dayString : currentDateInString))
        print(events2)
        //print(events[0])
        // Do any additional setup after loading the view, typically from a nib.
        if(events2.count > 11){
            endI = 11
        } else { endI = events2.count - 1}
        setup(startI: 0)
        // setup(startI: 12, endI: 23)
    }
    
    func filter(eventsFull: Array<[NSManagedObject]>, day : Date) -> Array<[NSManagedObject]> {
        var eventsFull = eventsFull
        
      
        var i : Int = 0
        var e = eventsFull
        for a in eventsFull{
            print("HHEERREE")
            if ((((a[0].value(forKey: "startDate")) as! Date) < day) || (((a[0].value(forKey: "startDate")) as! Date) > day.addingTimeInterval(86400))){
                print("in here:"+(a[0].value(forKey: "name") as! String))
                e.remove(at: i)
                i-=1
            }
            i+=1
        }
        return e
    }
    
    @IBAction func swipeUp(_ sender: Any) {
        scrollCount = scrollCount + 1
        print(scrollCount * 12)
        print("___")
        print(events2.count)
        print(12 * scrollCount >= events2.count)
        if(12 * scrollCount  >= events2.count){
            print("done")
            scrollCount = scrollCount - 1
            return
        }
        setup(startI: 12 * scrollCount)
    }
    @IBAction func swipeDown(_ sender: Any) {
        scrollCount = scrollCount - 1
        if(scrollCount < 0){
           scrollCount = scrollCount + 1
            return
        }
        setup(startI: 12 * scrollCount)
    }
    
    public func setCurrentDateInString(d: String){
        currentDateInString = d
    }
    
    func setup(startI: Int){
        endI = (events2.count) - (events2.count - (scrollCount * 12)) - 2
        print("________________" + String(endI))
        if(events2.count - endI > 11){
            endI = 11 + scrollCount * 12
        }else{
            endI = events2.count % 12 + scrollCount * 12 - 1
        }
        print("endI = " + String(endI))
        print(startI)
        view.subviews.forEach({ $0.removeFromSuperview() })
        setBackButton()
        setDateLabel()
        var div = endI - startI
        if(div < 2){
            div = 2
        }
        
        let yDifference = (Int(UIScreen.main.bounds.height) - 250) / div
        var i = endI
        if (endI > events2.count - 1){
            i = events2.count - 1
        }
        
        while i >= startI {
            let eventLabel = UILabel()
            eventLabel.frame = CGRect(x: 207, y: 150
                + (yDifference * (i % 12)), width: 300, height: 30)
            eventLabel.center.x = self.view.center.x
            print(i)
            print(events2.count)
            print(events2[i][0])
            eventLabel.text = String(events2[i][0].value(forKey: "name") as! String)
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
            createDeleteButton(i: i % 12, yDifference: yDifference)
            
            i = i - 1
        }
    }
    func setBackButton(){
        let btn = UIButton(type: .custom)
        btn.frame = .init(x: 25, y: 60, width: 60, height: 20)
        btn.setTitle("Back", for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        
        // you must call this for rounded corner
        btn.layer.masksToBounds = true
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(backButton(Back: )), for: .touchUpInside)
        //  print(offsetX, offsetY, 0%400)
    }
    @objc func backButton(Back: Int){
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
    
    func createDeleteButton(i: Int, yDifference: Int){
        let btn = UIButton(type: .custom)
        btn.frame = .init(x: 370, y: 150
            + (yDifference * (i % 12)), width: 20, height: 20)
        btn.setTitle("-", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        
        // you must call this for rounded corner
        btn.layer.masksToBounds = true
        self.view.addSubview(btn)
        //  print(offsetX, offsetY, 0%400)
        addTarget(btn: btn, i: i)
    }
    
    func addTarget(btn: UIButton, i: Int){
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
        }else if(i == 7){
            btn.addTarget(self, action: #selector(delete7(delete: )), for: .touchUpInside)
        }else if(i == 8){
            btn.addTarget(self, action: #selector(delete8(delete: )), for: .touchUpInside)
        }else if(i == 9){
            btn.addTarget(self, action: #selector(delete9(delete: )), for: .touchUpInside)
        }else if(i == 10){
            btn.addTarget(self, action: #selector(delete10(delete: )), for: .touchUpInside)
        }else if(i == 11){
            btn.addTarget(self, action: #selector(delete11(delete: )), for: .touchUpInside)
        }
    }
    
    @objc func delete0(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 0][0] )
        events2.remove(at: scrollCount * 12 + 0 )
        print(events2.count)
        if(events2.count == 0){
            print("0")
            endI = 0
            setup(startI: 0)
            return
        }
        //setup(startI: scrollCount * 12)
        print("del0")
        if(scrollCount * 12 - endI == 0){
            scrollCount = scrollCount - 1
            if(scrollCount < 0){
                scrollCount = scrollCount + 1
                return
            }
        }
            setup(startI: 12 * scrollCount)
    }
    
    @objc func delete1(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 1][0])
        events2.remove(at: scrollCount * 12 + 1 )
        setup(startI: scrollCount * 12)
        print("del1")
    }
    
    @objc func delete2(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 2][0])
        events2.remove(at: scrollCount * 12 + 2 )
        setup(startI: scrollCount * 12)
        print("del2")
    }
    
    @objc func delete3(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 3][0])
        events2.remove(at: scrollCount * 12 + 3 )
        setup(startI: scrollCount * 12)
        print("del3")
    }
    
    @objc func delete4(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 4][0])
        events2.remove(at: scrollCount * 12 + 4 )
        setup(startI: scrollCount * 12)
        print("del4")
    }
    
    @objc func delete5(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 5][0])
        events2.remove(at: scrollCount * 12 + 5 )
        setup(startI: scrollCount * 12)
        print("del5")
    }
    
    @objc func delete6(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 6][0])
        events2.remove(at: scrollCount * 12 + 6 )
        setup(startI: scrollCount * 12)
        print("del6")
    }
    
    @objc func delete7(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 7][0])
        events2.remove(at: scrollCount * 12 + 7 )
        setup(startI: scrollCount * 12)
        print("del7")
    }
    
    @objc func delete8(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 8][0])
        events2.remove(at: scrollCount * 12 + 8 )
        setup(startI: scrollCount * 12)
        print("del8")
    }
    
    @objc func delete9(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 9][0])
        events2.remove(at: scrollCount * 12 + 9 )
        setup(startI: scrollCount * 12)
        print("del9")
    }
    
    @objc func delete10(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 10][0])
        events2.remove(at: scrollCount * 12 + 10 )
        setup(startI: scrollCount * 12)
        print("del10")
        
    }
    @objc func delete11(delete: Int){
        deleteEventByName(name: events2[scrollCount * 12 + 11][0])
        events2.remove(at: scrollCount * 12 + 11 )
        setup(startI: scrollCount * 12)
        print("del11")
    }
    
    func getEventDay(n: String) -> Array<[NSManagedObject]> {
        
        var eventDay : Array<[NSManagedObject]> = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        
        //filters the events for the day
        
        //fetchRequest.predicate = NSPredicate(format: "date = %@", DateFormatter.date(from: n + "T00:00:00+0000")! as CVarArg)
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
                eventDay.append([data])
                print("end7")
            }
            
        } catch {
            print("Failed")
        }
        
        return eventDay
    }
    
    func deleteEventByName(name:String){
        
            //make the date fromatted
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            //dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
            //Creates a retchRequest which has access to all events in the database
            let context = AppDelegate.getContext()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
            let date = dateFormatter.date(from: name+"T00:00:00+0000")
            //fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(Entity.startDate), date! as CVarArg)
        
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
