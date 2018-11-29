//
//  mytools.swift
//  celatest1
//
//  Created by 徐勇 on 2018/11/28.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import Foundation
class mytools{
    class func returnDateString(date:NSDate)->String
    {
        let dateFormate=DateFormatter()
        dateFormate.locale=NSLocale(localeIdentifier: "ch") as Locale
        dateFormate.dateFormat="MM.dd"
      let dateString = dateFormate.string(from: date as Date)
        return dateString
    }
    enum WeekDays:String {
        
        case Monday="周一"
        case Tuesday="周二"
        case Wednesday="周三"
        case Thursday="周四"
        case Friday="周五"
        case Saturday="周六"
        case sunday="周日"
    }
    class func returnWeekDay(date:NSDate)->String
    {
       
        let dateFormate=DateFormatter()
        dateFormate.locale=NSLocale(localeIdentifier: "ch") as Locale
        dateFormate.dateFormat="EEEE"
        let dateString = dateFormate.string(from: date as Date)
        switch dateString {
            case "Monday":
            return WeekDays.Monday.rawValue
        case "Tuesday":
            return WeekDays.Tuesday.rawValue
        case "Wednesday":
            return WeekDays.Wednesday.rawValue
        case "Thursday":
            return WeekDays.Thursday.rawValue
        case "Friday":
            return WeekDays.Friday.rawValue
        case "Saturday":
            return WeekDays.Saturday.rawValue
        case "sunday":
            return WeekDays.sunday.rawValue
        default:
            return "错误了"
        }
        
    }
}
