//
//  CalendarHelper.swift
//  Proof
//
//  Created by YUJIN KWON on 2022/11/16.
//

import UIKit

class CalendarHelper {
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func monthString(date: Date) -> String {
        dateFormatter.dateFormat = "MM월"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy년"
        return dateFormatter.string(from: date)
    }
    
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date) ?? Date()
    }
    
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date) ?? Date()
    }

//MARK:  - Monthly
    
    func daysInMonth(date: Date) -> Int {
        return calendar.range(of: .day, in: .month, for: date)?.count ?? Int()
    }
    
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components) ?? Date()
    }
    
    func weekDay(date: Date) -> Int {
        return calendar.component(.weekday, from: date) - 1
    }
    
    
    //MARK:  - Weekly
    
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day ?? Int()
    }
    
    func addDays(date: Date, days: Int) -> Date {
        return calendar.date(byAdding: DateComponents(day: days), to: date) ?? Date()
    }
    
    func sundayForDate(date: Date) -> Date {
        var current = date
        let oneWeekAgo = addDays(date: current, days: -7)
        
        while current > oneWeekAgo {
            let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
            
            if currentWeekDay == 1 {
                return current
            } else {
                current = addDays(date: current, days: -1)
            }
        }
        
        return current
    }
    
}
