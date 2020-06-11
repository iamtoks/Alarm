//
//  Alarm.swift
//  Alarm
//
//  Created by adetokunbo babatunde on 6/8/20.
//  Copyright © 2020 AdetokunboBabatunde. All rights reserved.
//

import Foundation

class Alarm: Codable {
    var name: String
    var isOn: Bool
    var uuid: String
    var fireDate: Date
    
    var fireTimeAsString: String {
        let date = fireDate
        let format = DateFormatter()
        format.dateFormat = "hh:mm"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    init(name: String, isOn: Bool, uuid: String = UUID().uuidString, fireDate: Date) {
        self.name = name
        self.isOn = isOn
        self.uuid = uuid
        self.fireDate = fireDate
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.name == rhs.name && lhs.isOn == rhs.isOn && lhs.fireDate == rhs.fireDate && lhs.fireTimeAsString == rhs.fireTimeAsString && lhs.uuid == rhs.uuid
    }
}

