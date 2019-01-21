//
//  EventMO.swift
//  Wh3nsDay
//
//  Created by Hritik Arasu on 1/21/19.
//  Copyright © 2019 Hritik Arasu. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class EmployeeMO: NSManagedObject {
    
    @NSManaged var name: String?
    @NSManaged var startDate: Date?
    @NSManaged var endDate: Date?
    var ifAlert: Bool?
    
    
    
    
    
}
