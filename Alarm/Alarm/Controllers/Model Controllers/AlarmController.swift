//
//  AlarmController.swift
//  Alarm
//
//  Created by adetokunbo babatunde on 6/8/20.
//  Copyright © 2020 AdetokunboBabatunde. All rights reserved.
//

import UIKit

protocol AlarmSchedulerDelegate {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

class AlarmController {
    
    //Singleton
    static let shared = AlarmController()
 
        
    //MARK: - Source of Truth
    var alarms: [Alarm] = []
    
//    var mockAlarms: [Alarm] {
//        let alarm1 = Alarm(name: "Alarm1", isOn: false, fireDate: Date())
//        let alarm2 = Alarm(name: "Alarm2", isOn: false, fireDate: Date())
//        let alarm3 = Alarm(name: "Alarm3", isOn: true, fireDate: Date())
//        return [alarm1, alarm2, alarm3]
//    }
    
    //MARK: - CRUD
    
    //Create
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(name: name, isOn: enabled, fireDate: fireDate)
        alarms.append(newAlarm)
        scheduleUserNotifications(for: newAlarm)
        saveToPersistenceStore()
    }
    
    //Update
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.name = name
        alarm.fireDate = fireDate
        alarm.isOn = enabled
        scheduleUserNotifications(for: alarm)
        saveToPersistenceStore()
        
    }
    
    // Delete
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
        cancelUserNotifications(for: alarm)
        saveToPersistenceStore()
    }
    
    //MARK: - Helper Methods
   static func toggleEnabled(for alarm: Alarm) {
        alarm.isOn = !alarm.isOn
        
//        if alarm.isOn == true {
//         scheduleUserNotifications(for: alarm)
//        } else {
//            cancelUserNotifications(for: alarm)
//        }
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Alarm.json") // <--- Change file (app) name
        return fileURL
        
    }
    
    // Save
    func saveToPersistenceStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(alarms) // Change S.O.T.
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding our alarm: \(error) -- \(error.localizedDescription)") // Update Error Message
        }
    }
    
    // Load
    func loadFromPeristenceStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            alarms = try jsonDecoder.decode([Alarm].self, from: data) // <-- Update S.O.T. & Update the decoded type
        } catch {
            print("Error decoding our data into alarm: \(error) -- \(error.localizedDescription)") // Update Error Message
        }
    }
}


extension AlarmController: AlarmSchedulerDelegate {
    func scheduleUserNotifications(for alarm: Alarm) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "Let's Go!"
        notificationContent.body = "It's time to shine!"
        notificationContent.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
}
