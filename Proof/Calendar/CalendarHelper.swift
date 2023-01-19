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
    var calendarDate = Date()
    
    func startDayOfTheWeek() -> Int {
        return calendar.component(.weekday, from: calendarDate - 1)
    }
    
    func endDate() -> Int {
        return calendar.range(of: .day, in: .month, for: calendarDate)?.count ?? Int()
    }
    
    func monthString(date: Date) -> String {
        dateFormatter.dateFormat = "MM월"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy년"
        return dateFormatter.string(from: date)
    }
    
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func addDays(date: Date, days: Int) -> Date {
        return calendar.date(byAdding: .day, value: days, to: date)!
    }
    
    func sundayForDate(date: Date) -> Date {
        var current = date
        let oneWeekAgo = addDays(date: current, days: -7)
        
        while(current > oneWeekAgo) {
            let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
            if(currentWeekDay == 1) {
                return current
            }
            current = addDays(date: current, days: -1)
        }
        return current
    }
    
}
