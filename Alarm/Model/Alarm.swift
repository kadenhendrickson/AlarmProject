//
//  Alarm.swift
//  Alarm
//
//  Created by Kaden Hendrickson on 5/6/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class Alarm: Codable {
   
    var fireDate: Date
    var name: String
    var enabled: Bool
    let uuid: String
    var fireTimeAsString: String {
      let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: fireDate)
    }
    
//    get {
//    let dateFormatter = DateFormatter()
//    return dateFormatter.string(from: fireDate)
//
//    }
//
//    var timeAsString: String {
//        let timeRemaining = Int(self.timeRemaining ?? 20 * 60)
//        let minutesRemaining = timeRemaining/60
//        let secondsRemaining = timeRemaining - ( minutesRemaining * 60 )
//        return String(format: , arguments: [minutesRemaining, secondsRemaining])
//    }
    
    init(fireDate: Date, name: String, enabled: Bool = true, uuid: String = UUID().uuidString){
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
    
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.fireDate == rhs.fireDate && lhs.name == rhs.name && lhs.uuid == rhs.uuid
    }
    
    
}
