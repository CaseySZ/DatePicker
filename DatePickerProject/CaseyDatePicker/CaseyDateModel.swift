//
//  CaseyDateModel.swift
//  DatePickerProject
//
//  Created by Casey on 15/11/2018.
//  Copyright © 2018 Casey. All rights reserved.
//

import UIKit

class CaseyDateModel: NSObject {


    // 返回一个月的天数
    static func daysOfMonth(_ month:Int, year:Int) -> Int {
    
        var dayCount = 0
        
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            dayCount = 31
        case 4, 6, 9, 11:
            dayCount = 30
        case 2:
            if (year%4 == 0 && (year%100 != 0 || year%400 == 0)) {
                dayCount = 29
            }else{
                dayCount = 28
            }
        default: break
            
        }
        
        
        return dayCount
    
    }

    static func daysArrOfMonth(_ month:Int, year:Int) -> Array<String> {
        
        var daysArr = Array<String>()
        let daysCount = self.daysOfMonth(month, year: year)
        for index in 1...daysCount {
            daysArr.append(String(index))
        }
        
        return daysArr
        
    }

    
    
    // 返回当前的年份
    static func getCurrentYear() ->  Int {
        
        let calendar = Calendar.init(identifier: .gregorian)
        let componets = calendar.component(.year, from: Date())
        return componets
    }
    
    // 获取当前月的天数
    static func getDaysOfCurrentMonth() ->  Int {
        
        let calendar = Calendar.init(identifier: .gregorian)
        let componets = calendar.component(.day, from: Date())
        return componets
    }
    
    static func dateArr() -> Array<Array<String>> {
        
        
        var targerArr = Array<Array<String>>()
        
        let currentYear = self.getCurrentYear()
        
        var yearArr = Array<String>()
        for index in currentYear-100...currentYear {
            yearArr.append(String(index))
        }
        
        
        var monthArr = Array<String>()
        for index in 1...12 {
            monthArr.append(String(index))
        }
        
        var daysArr = Array<String>()
        for index in 1...self.getDaysOfCurrentMonth() {
            daysArr.append(String(index))
        }
        
        targerArr.append(yearArr)
        targerArr.append(monthArr)
        targerArr.append(daysArr)
        
        return targerArr
        
    }
}


