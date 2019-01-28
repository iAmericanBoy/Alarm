//
//  Alarm.swift
//  Alarm
//
//  Created by Dominic Lanzillotta on 1/28/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import Foundation


class Alarm {
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String = ""
    
    var fireTimeAsString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd'T'HH:mm:ss")
            return dateFormatter.string(from: fireDate)
        }
    }
    
    init(name: String, fireDate: Date, enabled: Bool) {
        self.name = name
        self.fireDate = fireDate
        self.enabled = enabled
    }
}

extension Alarm: Equatable{
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.name == rhs.name && lhs.fireDate == rhs.fireDate && lhs.enabled == rhs.enabled && lhs.uuid == rhs.uuid
    }
    
    
}
