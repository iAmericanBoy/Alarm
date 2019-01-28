//
//  AlarmController.swift
//  Alarm
//
//  Created by Dominic Lanzillotta on 1/28/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import Foundation

class AlarmController {
    
    //MARK: Singleton
    static let shared = AlarmController()
    
    //MARK: Source of truth
    var alarms: [Alarm] = []
    
    //MARK: CRUD
    //create
    func addAlarmWith(name: String,fireDate: Date, enabled: Bool) {
        let newAlarm = Alarm(name: name, fireDate: fireDate, enabled: enabled)
        alarms.append(newAlarm)
    }
    
    //read
    
    //update
    func update(alarm: Alarm, withName name: String, fireDate: Date, enabled: Bool) {
        guard let index = alarms.index(of: alarm) else {return}
        alarms[index].name = name
        alarms[index].fireDate = fireDate
        alarms[index].enabled = enabled
    }
    
    //delete
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else {return}
        alarms.remove(at: index)
    }
}
