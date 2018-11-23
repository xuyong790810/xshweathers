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
}
