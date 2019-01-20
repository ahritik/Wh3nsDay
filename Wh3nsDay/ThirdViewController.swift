//
//  ThirdViewController.swift
//  Wh3nsDay
//
//  Created by Hritik Arasu on 1/19/19.
//  Copyright © 2019 Hritik Arasu. All rights reserved.
//

import UIKit
import Foundation

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func getEvent() {
        let moc = …
        let employeesFetch = NSFetchRequest(entityName: "Entity")
        
        do {
            let fetchedEmployees = try moc.executeFetchRequest(employeesFetch) as! [EmployeeMO]
        } catch {
            fatalError("Failed to fetch Events: \(error)")
        }
    }
    
    
}
