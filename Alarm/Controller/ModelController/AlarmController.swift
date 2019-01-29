//
//  AlarmController.swift
//  Alarm
//
//  Created by Dominic Lanzillotta on 1/28/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import Foundation

class AlarmController {
    
    //MARK: - Singleton
    static let shared = AlarmController()
    
    //MARK: - Source of truth
    var alarms: [Alarm] = []
    
    //MARK: - CRUD
    //create
    func addAlarmWith(name: String,fireDate: Date, enabled: Bool) {
        let newAlarm = Alarm(name: name, fireDate: fireDate, enabled: enabled)
        alarms.append(newAlarm)
        saveToPersistanceStorage()
    }
    
    //read
    //update
    func update(alarm: Alarm, withName name: String, fireDate: Date, enabled: Bool) {
        guard let index = alarms.index(of: alarm) else {return}
        alarms[index].name = name
        alarms[index].fireDate = fireDate
        alarms[index].enabled = enabled
        saveToPersistanceStorage()
    }
    func toggleEnable(for alarm:Alarm) {
        guard let index = alarms.index(of: alarm) else {return}
        alarms[index].enabled = !alarm.enabled
        saveToPersistanceStorage()
    }
    
    //delete
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else {return}
        alarms.remove(at: index)
        saveToPersistanceStorage()
    }
    
//    //MARK: - MockData
//    var mockAlarms: [Alarm] {
//        get {
//            let alarm1 = Alarm(name: "firstAlarm", fireDate: Date(timeIntervalSinceNow: 1000), enabled: true)
//            let alarm2 = Alarm(name: "secondAlarm", fireDate: Date(timeIntervalSinceNow: 500), enabled: false)
//            let alarm3 = Alarm(name: "thirdAlarm", fireDate: Date(timeIntervalSinceNow: 100), enabled: false)
//            let alarm4 = Alarm(name: "fourthAlarm", fireDate: Date(timeIntervalSinceNow: 10000), enabled: true)
//            return [alarm1,alarm2,alarm3,alarm4]
//        }
//    }
    
    //MARK: - Persistance
    private var fileUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Alarms.json")
    }
    
    private func saveToPersistanceStorage() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(alarms)
            try data.write(to: fileUrl)
        } catch let error {
            print("An Error during save has accured. The message is \(String(describing: error))")
        }
    }
    
    func loadFromPersistantStorage() {
        let jsonDecoder = JSONDecoder()
        
        do{
            let data = try Data(contentsOf: fileUrl)
            self.alarms = try jsonDecoder.decode([Alarm].self, from: data)
        } catch let error {
            print("An Error during load has accured. The message is \(String(describing: error))")
        }
    }
    
}
