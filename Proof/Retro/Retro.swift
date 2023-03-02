//
//  Retro.swift
//  Proof
//
//  Created by YUJIN KWON on 2023/03/02.
//

import Foundation

var retrosList = [Retro]()

class Retro {
    var id: Int!
    var date: Date!
    var category: String!
    var liked: String!
    var lacked: String!
    var learned: String!
    var longedFor: String!
    
    func retrosForDate(date: Date) -> [Retro] {
        
        var daysRetro = [Retro]()
        
        for retro in retrosList {
            if Calendar.current.isDate(retro.date, inSameDayAs: date) {
                daysRetro.append(retro)
            }
        }
        return daysRetro
    }
}
