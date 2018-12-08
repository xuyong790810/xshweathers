//
//  MainViewController.swift
//  celatest1
//
//  Created by 徐勇 on 2018/9/28.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var mytable:UITableView?
    var image:UIImageView?
    var btn:UIButton?
    var header=MJRefreshNormalHeader()
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutNavgate(date: mytools.returnDateString(date: NSDate()), weekDay: mytools.returnWeekDay(date: NSDate()), city: "北海")
        downloadData(cityname: "北海")
    mytable=UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        self.view.addSubview(mytable!)
    mytable?.mj_header=header
        header.refreshingBlock={
            self.layoutNavgate(date: mytools.returnDateString(date: NSDate()), weekDay: mytools.returnWeekDay(date: NSDate()), city: "南宁")
            self.downloadData(cityname: "南宁")
        }
        
    }
    
    func layoutNavgate(date:String,weekDay:String,city:String)
    {
        
        self.navigationController?.navigationBar.tintColor=UIColor.white
        let catogryBarItem=UIBarButtonItem(image: UIImage(named: "category_hover"), style: .plain, target: self, action: #selector(chooseAction))
        let dateBarItem=UIBarButtonItem(title: date+"/"+weekDay, style: .plain, target: self, action: #selector(chooseAction))
        let cityBarItem=UIBarButtonItem(title: city, style: .plain, target: nil, action: nil)
        let settingBarItem=UIBarButtonItem(image: UIImage(named: "settings_normal"), style: .plain, target: self, action: #selector(setting))
        let shareBarItem=UIBarButtonItem(image: UIImage(named: "share_small_link"), style: .plain, target: self, action: #selector(shares))
        self.navigationItem.rightBarButtonItems=[shareBarItem,cityBarItem,settingBarItem]
        self.navigationItem.leftBarButtonItems=[catogryBarItem,dateBarItem]
    }
    @objc func shares()
    {
        print("share")
    }
    @objc func setting()
    {
        print("setting")
    }
    @objc   func chooseAction()
    {
        print("choosedate")
    }
    
    @objc func downloadData(cityname:String)
    {
        let urlstr="http://api.k780.com:88/?app=weather.future&weaid=\(cityname)&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json"
        //下面这句允许url里有中文
        let urlst=urlstr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //把字符串转换成URL格式
        let url=URL(string: urlst!)
        let session=URLSession.shared
        let datatask =   session.dataTask(with: url!) { (data, reponse, error) in
        var jsonstr:NSDictionary?
            
        if data != nil{
                jsonstr=try?
                JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                let weathers = jsonstr!["result"] as! NSArray
                let weather=weathers[0] as! NSDictionary
                let weatherstr=weather["weather"] as! String
            //发送通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leftdata"), object: nil, userInfo: ["data":weathers])
               
                DispatchQueue.main.async {
                    self.view.backgroundColor=tool.retrunweatherColor(weatherType: weatherstr)
                   self.mytable?.backgroundColor=tool.retrunweatherColor(weatherType: weatherstr)
                    self.navigationController?.navigationBar.backgroundColor=tool.retrunweatherColor(weatherType: weatherstr)
                    self.header.endRefreshing()
                //self.view.backgroundColor = tool.returnWeatherBGColor(weatherType: weatherstr)
                }
            }
        }
        datatask.resume()
        
    }
    
    @objc func btnclick()
    {
        
        let url:URL=URL(string: "http://api.k780.com:88/?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")!
        
        let session=URLSession.shared
        //定义一个网络请求对象
        //接下来网络请求定义任务
        let task=session.dataTask(with: url) { (data, respone, error) in
            //第一步 接受的数据进行json序列化
        let myInfo=try?      JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        //逐层解析数据
        let weathers = myInfo!["result"] as! NSArray
        let weather=weathers[0] as! NSDictionary
        let week=weather["weather"] as! String
        print(week)
        }
        //发送网络请求
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
