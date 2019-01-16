//
//  Event.swift
//  WhensDay
//
//  Created by Hritik Arasu on 12/3/18.
//  Copyright © 2018 Dane Potter. All rights reserved.
//

import Foundation

public class Event{
    
    private var name : String
    private var ifAlert : Bool
    private var startDate : Date
    private var endDate : Date
    private var DOW : Int
    
    init(n:String, s : Date,e : Date,a : Bool){
        name = n
        startDate = s
        endDate = e
        ifAlert = a
        DOW = Calendar.current.component(.weekday, from: startDate)
    }
    
    public func getStart() -> Date {
        return startDate
    }
    
    public func getEnd() -> Date {
        return endDate
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getAlerts() -> Bool {
        return ifAlert
    }
    
    public func changeName(n : String){
        name = n
    }
    
    public func equals(ev : Event) -> Bool{
        if(self.startDate != ev.startDate){
            return false
        } else if(self.endDate != ev.endDate ){
            return false
        }
        return true
    }
    
}

