//
//  Tools.swift
//  celatest1
//
//  Created by 徐勇 on 2018/11/23.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import Foundation
class Tools
{
   class  func returnDateString(date:NSDate)->String {
        let dateFormatter=DateFormatter()
        dateFormatter.locale=NSLocale(localeIdentifier: "ch") as Locale
        dateFormatter.dateFormat="MM.dd"
    let datestring = dateFormatter.string(from: date as Date)
        return datestring
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
    class func returnWeekdayString(date:NSDate) ->String{
        let dateFormatter=DateFormatter()
        dateFormatter.locale=NSLocale(localeIdentifier: "ch") as Locale
        dateFormatter.dateFormat="EEEE"
        let datestring = dateFormatter.string(from: date as Date)
        switch datestring {
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
//https://github.com
