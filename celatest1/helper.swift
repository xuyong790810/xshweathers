//
//  helper.swift
//  celatest1
//
//  Created by 徐勇 on 2018/11/28.
//  Copyright © 2018年 徐勇. All rights reserved.
//

let LeftControllerTypeChangedNotification = "LeftControllerTypeChangedNotification"
let AutoLocationNotification = "AutoLocationNotification"
let chooseCityLocationNotification="chooseCityLocationNotification"
let history_City_Path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]+"/"+"history_City_Path.text"
class helper:NSObject
{
    class func readCashCity()->[String]
    {
        var cityArray=NSArray(contentsOfFile: history_City_Path)
        if cityArray==nil
        {
            return []
        }
        else
        {
            if cityArray?.count==0
            {
                return []
            }
            else
            {
                var citys=[String]()
                for ele in citys
                {
                    citys.append(ele)
                }
                return citys
            }
            
        }
        
    }
    class func insertCity(city:String)->Bool
    {
        var oldCity=readCashCity()
   if oldCity.contains(city)
   {
    let index=oldCity.firstIndex(of: city)
    oldCity.remove(at: index!)
    }
     oldCity.insert(city, at: 0)
        let array=NSMutableArray()
        for ele in oldCity
        {
           array.add(ele)
        }
        return array.write(toFile: history_City_Path, atomically: true)
    }
    class func deleteCity(city:String)->Bool
    {
        var oldCity=readCashCity()
        if oldCity.contains(city)
        {
            let index=oldCity.firstIndex(of: city)
            oldCity.remove(at: index!)
        }
        let array=NSMutableArray()
        for ele in oldCity
        {
            array.add(ele)
        }
         return array.write(toFile: history_City_Path, atomically: true)
    }
    
}
