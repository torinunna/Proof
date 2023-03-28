//
//  CalendarDay.swift
//  Proof
//
//  Created by YUJIN KWON on 2023/03/28.
//

import Foundation

class CalendarDay {
    var day: String!
    var month: Month!
    
    enum Month {
        case previous
        case current
        case next
    }
}
