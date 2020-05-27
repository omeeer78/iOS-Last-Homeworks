//
//  DateManager.swift
//  RequestsLesson
//
//  Created by Amir on 29.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import Foundation

class DateManager {
    
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    static var relativeDateFormatter: RelativeDateTimeFormatter = {
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.locale = Locale(identifier: "ru_RU")
        return relativeFormatter
    }()
    
    class func reformDate(_ date: Date) -> String {
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        if calendar.compare(date, to: Date(), toGranularity: .hour) == .orderedSame {
            return relativeDateFormatter.localizedString(for: date, relativeTo: currentDate)
        } else if calendar.isDateInToday(date) {
            
            dateFormatter.dateFormat = "Сегодня в HH:mm"
            return dateFormatter.string(from: date)
        } else if calendar.isDateInYesterday(date) {
            
            dateFormatter.dateFormat = "Вчера в HH:mm"
            return dateFormatter.string(from: date)
        } else {
            
            dateFormatter.dateFormat = "dd.MM.yyyy в HH:mm"
            return dateFormatter.string(from: date)
        }
    }
    
    
    class func dayDifference(from interval : TimeInterval) -> String {
        
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: interval)
        let startOfNow = calendar.startOfDay(for: Date())
        let startOfTimeStamp = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
        let day = components.day!
        
        if abs(day) < 2 {
            
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            dateFormatter.doesRelativeDateFormatting = true
            
            return dateFormatter.string(from: date)
            
        } else if day > 1 {
            return "In \(day) days"
        } else {
            return "\(-day) days ago"
        }
    }
}
