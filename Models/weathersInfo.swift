//
//  File.swift
//  celatest1
//
//  Created by 徐勇 on 2018/11/28.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import Foundation
class weathersInfo:NSObject{
//    var  cityid:String?
//    var  citynm :String?
//    var  cityno:String?
//    var days:String?
//    var humi_high:String?
//    var humi_low:String?
//   var humidity:String?
//    var temp_high:String?
//    var temp_low:String?
//   var  temperature:String?
//   var weaid:String?
//   var weather:String?
//   var weather_icon:String?
//   var weather_icon1:String?
//   var weather_iconid:String?
//   var weather_iconid1:String?
//   var weatid:String?
//    var weatid1:String?
//   var week :String?
//   var wind:String?
//  var  windid:String?
//   var winp:String?
//   var winpid :String?
 @objc  var weaid:String?
 @objc   var days:String?
  @objc  var week:String?
  @objc  var cityno:String?
  @objc  var citynm:String?
  @objc  var cityid:String?
  @objc  var temperature:String?
  @objc  var humidity:String?
  @objc  var weather:String?
  @objc  var weather_icon:String?
   @objc var weather_icon1:String?
   @objc var wind:String?
   @objc var winp:String?
   @objc var temp_high:String?
  @objc  var temp_low:String?
  @objc  var humi_high:String?
  @objc  var humi_low:String?
  @objc  var weatid:String?
  @objc  var weatid1:String?
  @objc  var windid:String?
  @objc  var winpid:String?
  @objc  var weather_iconid:String?
   @objc var weather_iconid1:String?
     init(dic:NSDictionary) {
        super.init()
        self.setValuesForKeys(dic as! [String : Any])
        
    }
}
