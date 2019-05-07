//
//  AlarmController.swift
//  Alarm
//
//  Created by Kaden Hendrickson on 5/6/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    func scheduleUserNotifications(alarm: Alarm)
    func cancelUserNotifications(alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(alarm: Alarm) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.body = "ALARM"
        notificationContent.title = "\(alarm.name)"
        notificationContent.sound = .default
        let dateComponents = Calendar.current.dateComponents([.minute, .hour], from: alarm.fireDate)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
       let request =  UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                 print("This here is an error mate: \(error) : \(error.localizedDescription)")
            }
        }
    }
    
    func cancelUserNotifications(alarm: Alarm) {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
    
}



class AlarmController: AlarmScheduler {
    
    static var sharedInstance = AlarmController()
    init() {
    alarms = loadFromPersistentStorage()
           }

    //MARK: Properties

    var alarms: [Alarm] = []
    
    //CRUD Functions
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
       let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
        saveToPersistentStorage()
        scheduleUserNotifications(alarm: newAlarm)
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm) {
        guard let indexOfAlarmToDelete = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: indexOfAlarmToDelete)
        cancelUserNotifications(alarm: alarm)
        saveToPersistentStorage()
        
    }
    
    func toggleIsOnFor(alarm: Alarm){
        if alarm.enabled == false{
            print("notification scheduled")
            scheduleUserNotifications(alarm: alarm)
            alarm.enabled = !alarm.enabled

        } else {
            print("notification cancled")
            cancelUserNotifications(alarm: alarm)
            alarm.enabled = !alarm.enabled
        }
    }
   
    //MARK: Persistence
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filename = "alarm.json"
        let fullURL = documentDirectory.appendingPathComponent(filename)
        return fullURL
    }
    
    func saveToPersistentStorage() {
        let jsonEncoder = JSONEncoder()
        do{
            let url = fileURL()
            let data = try jsonEncoder.encode(alarms)
            try data.write(to: url)
        } catch let error {
            print("There was an error: \(error)")
        }
    }
    
    func loadFromPersistentStorage() -> [Alarm] {
        let jsonDecoder = JSONDecoder()
        do{
            let url = fileURL()
            let data = try Data(contentsOf: url)
            let alarm = try jsonDecoder.decode([Alarm].self, from: data)
            return alarm
        } catch let error {
            print("There was an error: \(error)")
        }
        return []
    }

}

