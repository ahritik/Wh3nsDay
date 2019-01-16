
//
//  FirstViewController.swift
//  WhensDay
//
//  Created by Dane Potter on 11/30/18.
//  Copyright © 2018 Dane Potter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    private var eventNameInput = ""
    private var alerts = true
    
    var configuration = Realm.Configuration(
        schemaVersion: 3,
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 3 {
                
                // if just the name of your model's property changed you can do this
                migration.renameProperty(onType: Event, from: "text", to: "title")
                
                // if you want to fill a new property with some values you have to enumerate
                // the existing objects and set the new value
                migration.enumerateObjects(ofType: Event) { oldObject, newObject in
                    let text = oldObject!["text"] as! String
                    newObject!["textDescription"] = "The title is \(text)"
                }
                
                // if you added a new property or removed a property you don't
                // have to do anything because Realm automatically detects that
            }
        }
    )
    
    // opening the Realm file now makes sure that the migration is performed
    let realm = try! Realm()
    
    let realm = try! Realm(configuration: Realm.Configuration(schemaVersion:3))
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var alertSwitch: UISwitch!
    @IBOutlet weak var startDatePickerInput: UIDatePicker!
    @IBOutlet weak var endDatePickerInput: UIDatePicker!
    @IBOutlet weak var eventNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        eventNameInput = textField.text ?? ""
        print(eventNameInput)
        self.view.endEditing(true)
    }
    
    @IBAction func switchSwitched(_ sender: UISwitch) {
        if (sender.isOn == true){
            alerts = true
        }else{
            alerts = false
        }
    }
    @IBAction func donePressed(_ sender: Any) { //pull the day with corisponding date from database.
        if(textField.text == ""){
            mustHaveNameError()
            return
        }
        
        print(alerts)
        print(startDatePickerInput.date)
        let startTimePast1970 = startDatePickerInput.date.timeIntervalSince1970
        let endTimePast1970 = endDatePickerInput.date.timeIntervalSince1970
        // convert to Integer
        let startTimeInt = Int(startTimePast1970)
        let endTimeInt = Int(endTimePast1970)
        print(startTimeInt)
        print(endTimeInt)
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let e = Event(n:eventNameInput, s:startDatePickerInput.date, e:endDatePickerInput.date, a:alerts)
        
        //        try! realm.write {
        //            realm.add(e.getName(),e.getStart(),e.getEnd(),e.getAlerts())
        //        }
        
        //        date = getIntDate()
        
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
