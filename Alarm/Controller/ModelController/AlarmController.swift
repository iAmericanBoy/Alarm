//
//  AlarmController.swift
//  Alarm
//
//  Created by Dominic Lanzillotta on 1/28/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmController: AlarmScheduler {
    
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
        if alarms[index].enabled {
            scheduleNotifications(for: alarm)
        } else {
            cancelNotifications(for: alarm)
        }
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

protocol AlarmScheduler {
    func scheduleNotifications(for alarm: Alarm)
    func cancelNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleNotifications(for alarm: Alarm) {
        let userNotificationContent = UNMutableNotificationContent()
        userNotificationContent.sound = UNNotificationSound.default
        userNotificationContent.title = alarm.name
        userNotificationContent.body = "Your Alarm is going off"
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: userNotificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("An error scheduling a notification has occured:\(String(describing: error.localizedDescription))")
            }
        }
    }
    func cancelNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}
