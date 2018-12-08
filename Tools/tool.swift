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
    class func returncolorString(hex:String)->UIColor
    {
        //FF6688
        //去掉一些字符whitespacesAndNewlines。uppercased()大写
        var cString:String=hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        //截取字符串
       let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2)as NSString).substring(to: 2)
        let bString=((cString as NSString).substring(from: 4)as NSString)
        //定义三个变量
         var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        //提取字符串里的数字，然后转换成int32数字，存储在r，g，b
        Scanner(string: rString).scanHexInt32(&r)
         Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString as String).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
        
    }
    class func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        // hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
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
    class func returnWeatherType(weatherType:String)->String
    {
        let weatherTypePath=Bundle.main.path(forResource: "weatherBG", ofType: "plist")
        if weatherTypePath != nil
        {
            let json=NSDictionary(contentsOfFile: weatherTypePath!)
            for element in (json?.allKeys)!
            {
                if weatherType.hasPrefix(element as! String)
                {
                    return element as! String
                }
            }
        }
        return weatherType
    }
    class func retrunweatherColor(weatherType:String)->UIColor
    {
        //获取plist文件内容
       let weatherTypePath=Bundle.main.path(forResource: "weatherBG", ofType: "plist")
        let jsonDic  = NSDictionary(contentsOfFile: weatherTypePath!)
        for element in (jsonDic?.allKeys)!
        {
           if element as! String==weatherType||weatherType.hasPrefix(element as! String)
           {
            let key=element as! String
            let value=jsonDic![key] as! String
            return tool.returncolorString(hex:value)
            }
        }
        return UIColor.gray
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
