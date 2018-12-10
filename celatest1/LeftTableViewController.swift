//
//  LeftTableViewController.swift
//  celatest1
//
//  Created by 徐勇 on 2018/10/24.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit

class LeftTableViewController: UITableViewController {
    //定义空数组
   var dataSource=[NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.backgroundColor=UIColor.black
        let nib = UINib(nibName: "LeftTableViewCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: "mycell")
        self.tableView.rowHeight=100
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection=false
        //通知中心添加监视
        NotificationCenter.default.addObserver(self, selector: #selector(refreshdata), name: NSNotification.Name(rawValue: "leftdata"), object: nil)
       
    }
    @objc   func refreshdata(sender:NSNotification)
    {
      //取出传过来的数组
        let userinfo=sender.userInfo!["data"] as! NSArray
        //清空原来的数组
        dataSource.removeAll()
      for fo in userinfo
      {
        let dic = fo as! NSDictionary
         dataSource.append(dic)
       
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
//
//                for info in userinfo
//                {
//                    let dic=info as! NSDictionary
//                   let weather=weathersInfo(dic: dic)
//                    dataSource.append(weather)
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//
//                }

     
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
        
        return dataSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! LeftTableViewCell
        //取一行数据
       let info = dataSource[indexPath.row]
        //从字典中取星期几
        cell.date1.text=info["week"] as! String
        //从字典里取日期
        let date2str=info["days"]
        //cell.date2.text=date2str as! String
       let dateformatter=DateFormatter()
        dateformatter.dateFormat="YYYY-MM-dd"
        let date = dateformatter.date(from: date2str! as! String )
        dateformatter.dateFormat="MM-dd"
        let date2string =  dateformatter.string(from: date!)
       cell.date2.text=date2string
       // cell.weather2.text=info["weather"] as! String
        cell.weather3.text=info["temperature"] as! String
        cell.weather2.text=tool.returnWeatherType(weatherType: info["weather"]! as! String)
//        cell.weather3.text=(info["temperature"] as! String)
        cell.view1.backgroundColor=tool.retrunweatherColor(weatherType: info["weather"] as! String)
//        //cell.view1.backgroundColor=tool.returnWeatherBGColor(weatherType: info["weather"]! as! String)
        //第一行是今天
        if indexPath.row==0
        {
            cell.date1.text="今天"
        }
        //第二行是明天
        if indexPath.row==1
        {
            cell.date1.text="明天"
        }
        return cell

       
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
