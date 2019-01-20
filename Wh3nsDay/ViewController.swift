
//
//  FirstViewController.swift
//  WhensDay
//
//  Created by Dane Potter on 11/30/18.
//  Copyright © 2018 Dane Potter. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    private var eventNameInput = ""
    private var alerts = true

    @IBOutlet weak var endDatePickerInput: UIDatePicker!
    @IBOutlet weak var startDatePickerInput: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var eventNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
  
    @IBAction func donePressed(_ sender: Any) {
        if(textField.text == ""){
            mustHaveNameError()
            return
        }
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "CalView") as! SecondViewController
        self.present(homeView, animated: false, completion: nil)
        print(alerts)
        //print(startDatePickerInput.)
        let startTimePast1970 = startDatePickerInput.date.timeIntervalSince1970
        let endTimePast1970 = endDatePickerInput.date.timeIntervalSince1970
        //convert to Integer
        let startTimeInt = Int(startTimePast1970)
        let endTimeInt = Int(endTimePast1970)
        print(startTimeInt)
        print(endTimeInt)
        
        addEvent()
        
    }
    
    @IBAction func switchSwitched(_ sender: UISwitch) {
        if (sender.isOn == true){
            alerts = true
        }else{
            alerts = false
        }
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        eventNameInput = textField.text ?? ""
        print(eventNameInput)
        self.view.endEditing(true)
    }
    
    func addEvent(){
        
        //Creates an accessor
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Accessor creates an Entity
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newEvent = NSManagedObject(entity: entity!, insertInto: context)
        
        //adds each of the required parts to the enity creates
        newEvent.setValue(eventNameInput, forKey: "name")
        newEvent.setValue(startDatePickerInput.date, forKey: "startDate")
        newEvent.setValue(startDatePickerInput.date, forKey: "endDate")
        newEvent.setValue(alerts, forKey: "ifAlert")
        
        //Saves the added event to the Core Data Database
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
    func mustHaveNameError(){
            self.eventNameLabel.text = "Must Include Event Name"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                self.textField.backgroundColor = .yellow
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    self.textField.backgroundColor = .red
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        self.textField.backgroundColor = .yellow
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                            self.textField.backgroundColor = .red
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                self.textField.backgroundColor = .yellow
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                    self.textField.backgroundColor = .red
                                }
                            }
                        }
                    }
                }
            }
        }

    
    
  
    
    
}

//@IBAction func switchSwitched(_ sender: UISwitch) {
//
//}
//
//@IBAction func donePressed(_ sender: Any) {
//    if(textField.text == ""){
//        mustHaveNameError()
//        return
//    }
//
//    print(alerts)
//    print(startDatePickerInput.date)
//    let startTimePast1970 = startDatePickerInput.date.timeIntervalSince1970
//    let endTimePast1970 = endDatePickerInput.date.timeIntervalSince1970
//    // convert to Integer
//    let startTimeInt = Int(startTimePast1970)
//    let endTimeInt = Int(endTimePast1970)
//    print(startTimeInt)
//    print(endTimeInt)
//
//    let e = Event(n:eventNameInput, s:startDatePickerInput.date, e:endDatePickerInput.date, a:alerts)
//
//    // print(startDatePicker.)
//}
//
//func mustHaveNameError(){
//    self.eventNameLabel.text = "Must Include Event Name"
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//        self.textField.backgroundColor = .yellow
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//            self.textField.backgroundColor = .red
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//                self.textField.backgroundColor = .yellow
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//                    self.textField.backgroundColor = .red
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//                        self.textField.backgroundColor = .yellow
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//                            self.textField.backgroundColor = .red
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
