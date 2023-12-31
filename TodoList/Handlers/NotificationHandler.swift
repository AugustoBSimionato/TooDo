//
//  NotificationHandler.swift
//  TodoList
//
//  Created by Augusto Simionato on 05/07/23.
//

import Foundation
import UserNotifications

class NotificationHandler {
    func sendNotification(date: Date, type: String, timeInterval: Double = 10, title: String, body: String) {
        var trigger: UNNotificationTrigger?
        
        if type == "date" {
            let dateComponentes = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponentes, repeats: false)
        } else if type == "time" {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
