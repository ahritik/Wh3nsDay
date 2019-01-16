//
//  Day.swift
//  WhensDay
//
//  Created by Dane Potter on 11/30/18.
//  Copyright © 2018 Dane Potter. All rights reserved.
//

import Foundation

public class Day{
    private var date : Int
    private var events = [Event]()
    private var size = 0
    
    init(d :Int) {
        date = d
    }
    func add(e :Event){
        if(size == 0){
            events.append(e)
        }else{
            var index = 0
            var done = false
            for ev in events{
                if(ev.getStart() < e.getStart()){
                    index = index + 1
                }else if(done == false){
                    events.insert(e, at: index)
                    done = true
                    size+=1
                }
            }
        }
    }
    func remove(ev :Event){
        if(size == 0){
        }else{
            var index = 0
            for event in events{
                if(event.equals(ev : ev)){
                    events.remove(at : index)
                    size -= 1
                }
                index += 1
            }
        }
    }
    
}

