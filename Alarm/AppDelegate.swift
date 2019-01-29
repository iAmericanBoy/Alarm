//
//  AppDelegate.swift
//  Alarm
//
//  Created by Dominic Lanzillotta on 1/28/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("permission has been granted")
            } else {
                print("permission has not been granted")
            }
            if let error = error {
                print("An error has occured:\(String(describing: error.localizedDescription))")
            }
        }
        AlarmController.shared.loadFromPersistantStorage()
        return true
    }
}

