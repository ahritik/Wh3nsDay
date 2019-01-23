
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

    @IBOutlet weak var endDatePickerInput: UIDatePicker!
    @IBOutlet weak var startDatePickerInput: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
  
    @IBAction func donePressed(_ sender: Any) { // when the done button is pressed this runs-dane
        if(textField.text == ""){ // makes sure there is an event name
            mustHaveNameError(label: "MUST INCLUE EVENT NAME") // runs method that flashes red and yellow in the text field so u see it and changes the "Event Name Label" to " MUST HAVE NAME"- dane
            return // stops method
        }
        if(eventNameInput.count > 16){
            mustHaveNameError(label: "Must be less than 16 characters") // same as above but for if its to long - dane
            return
        }
        
        //Adds the event entered
        addEvent(n: eventNameInput, s: startDatePickerInput.date, e: endDatePickerInput.date)
        
        let homeView = self.storyboard?.instantiateViewController(withIdentifier: "CalView") as! SecondViewController // switches back to calendar view when done adding - dane
        self.present(homeView, animated: false, completion: nil)
        //print(alerts)
        print(startDatePickerInput.date) // print check

        
        
    }
    
    func addEvent(n: String, s: Date, e: Date){ // we originally were going to use alerts but ended up deciding not to. - h
        let context = AppDelegate.getContext()
        
        //Accessor creates an Entity
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newEvent = NSManagedObject(entity: entity!, insertInto: context)
        
        //adds each of the required parts to the enity creates - h
        newEvent.setValue(n, forKey: "name")
        newEvent.setValue(s, forKey: "startDate")
        newEvent.setValue(e, forKey: "endDate")
        newEvent.setValue(false, forKey: "ifAlert")
        
        //Saves the added event to the Core Data Database - h
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
    
    @IBAction func returnPressed(_ sender: Any) { // when return on keyboard is pressed- dane
        eventNameInput = textField.text ?? ""
        print(eventNameInput)
        if(eventNameInput.count > 16){
            mustHaveNameError(label: "Must be less than 16 characters") // checks input for to long -d
        }
        self.view.endEditing(true) // hides keyboard - dane
    }
    
    func mustHaveNameError(label: String){
            self.eventNameLabel.text = label
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


