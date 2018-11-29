//
//  LeftTableViewController.swift
//  celatest1
//
//  Created by 徐勇 on 2018/10/24.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit

class LeftTableViewController: UITableViewController {
    var dataSource=[weathersInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "LeftTableViewCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: "mycell")
        self.tableView.rowHeight=100
        NotificationCenter.default.addObserver(self, selector: #selector(refreshdata), name: NSNotification.Name(rawValue: LeftControllerTypeChangedNotification), object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(refreshdata), name: NSNotification.Name(rawValue: LeftControllerTypeChangedNotification), object: nil)
    }
    @objc   func refreshdata(sender:NSNotification)
    {
       
        let userinfo=sender.userInfo!["data"] as! NSArray
        //dataSource=userinfo as! [NSDictionary]
                for info in userinfo
                {
                    let dic=info as! NSDictionary
                   let weather=weathersInfo(dic: dic)
                    dataSource.append(weather)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
        
                }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
        
//       for info in userinfo
//       {
//        let dic=info as! NSDictionary
//
//        }
//
//        for info in userinfo
//        {
//            let dic=info as! NSDictionary
//            // let weather=weathersInfo(dic: dic)
//            dataSource.append(dic)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//
//        }
     
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.dataSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! LeftTableViewCell
        let info=dataSource[indexPath.row]
        cell.date1.text=info.week as! String
        let date2=info.days
        let dateformatter=DateFormatter()
        dateformatter.dateFormat="YYYY-MM-dd"
        let date = dateformatter.date(from: date2! as! String)
        
        dateformatter.dateFormat="MM-dd"
        let date2string =  dateformatter.string(from: date!)
        cell.date2.text=date2string
               cell.weather2.text=info.weather as? String
                cell.weather3.text=info.temperature as? String
        cell.view1.backgroundColor=tool.returnWeatherBGColor(weatherType: info.weather!)
        if indexPath.row==0
        {
            cell.date1.text="今天"
        }
        if indexPath.row==1
        {
            cell.date1.text="明天"
        }
        return cell
//        let info=dataSource[indexPath.row]
//        cell.date1.text=info["week"] as? String
//        var date2=info["days"] as? String
//
//        let dateformatter=DateFormatter()
//        dateformatter.dateFormat="YYYY-MM-dd"
//     let date =   dateformatter.date(from: date2!)
//        dateformatter.dateFormat="MM-dd"
//        let date2string =  dateformatter.string(from: date!)
//        cell.date2.text=date2string
//        cell.weather2.text=info["weather"] as? String
//        cell.weather3.text=info["temperature"] as? String
//        //        let dayWeatherInfo = self.dataSource[indexPath.row]
//        //        cell.dateLabel.text = Tool.retrunNeedDay(dayWeatherInfo.days!)
//        //        cell.weekDayLabel.text = Tool.returnWeekDay(dayWeatherInfo.week!)
//        //        cell.temperatureLabel.text = dayWeatherInfo.temp_low! + "~" + dayWeatherInfo.temp_high!
//        //        cell.weatherLabel.text = Tool.returnWeatherType(dayWeatherInfo.weather!)
//        //        cell.weatherBgView.backgroundColor = Tool.returnWeatherBGColor(dayWeatherInfo.weather!)
       
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
