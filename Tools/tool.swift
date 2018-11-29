//
//  tool.swift
//  celatest1
//
//  Created by 徐勇 on 2018/11/28.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit
class tool
{
    class func returnDateString(date:NSDate)->String
   {
    let dateFormat=DateFormatter()
    dateFormat.locale=NSLocale(localeIdentifier: "ch") as Locale
    dateFormat.dateFormat="MM.dd"
    let dateString=dateFormat.string(from: date as Date)
    return dateString
    }
    enum weekDays:String {
        case Monday="周一"
        case Tuesday="周二"
        case Wednesday="周三"
        case Thursday="周四"
        case Friday="周五"
        case Saturday="周六"
        case sunday="周日"
    }
    class func returnWeekDayString(date:NSDate)->String
    {
        let dateFormat=DateFormatter()
        dateFormat.locale=NSLocale(localeIdentifier: "ch") as Locale
        dateFormat.dateFormat="EEEE"
        let weekDayString=dateFormat.string(from: date as Date)
        switch weekDayString {
        case "Monday":
            return weekDays.Monday.rawValue
        case "Tuesday":
            return weekDays.Tuesday.rawValue
        case "Wednesday":
            return weekDays.Wednesday.rawValue
        case "Thursday":
            return weekDays.Thursday.rawValue
        case "Friday":
            return weekDays.Friday.rawValue
        case "Saturday":
            return weekDays.Saturday.rawValue
        case "sunday":
            return weekDays.sunday.rawValue
        default:
            return "出错"
        }
        
    }
    class func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        // hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        //取到六位十六进制数的前2位
        let rString = (cString as NSString).substring(to: 2)
       //取到六位十六进制数的3，4位
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        //substring(from: 2))指的是从第三位开始取，直到末尾
      //print(  (cString as NSString).substring(from: 0))
       
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        //取到六位十六进制数的最后2位
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func returnWeatherBGColor(weatherType:String)->UIColor {
        let weatherTypePath = Bundle.main.path(forResource: "weatherBG", ofType: "plist")
        if weatherTypePath != nil {
            let json = NSDictionary(contentsOfFile: weatherTypePath!)
            
            for element in (json?.allKeys)! {
                if element as! String == weatherType || weatherType.hasPrefix(element as! String) {
                    let key = element as! String
                    let value = json![key] as! String
                    return tool.colorWithHexString(hex: value)
                }
            }
        }
        
        return UIColor.gray
        
    }
}
