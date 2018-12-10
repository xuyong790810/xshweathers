//
//  MainViewController.swift
//  celatest1
//
//  Created by 徐勇 on 2018/9/28.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "maincell") as! MainTableViewCell
       // cell.weahterLabel1.text=dataSource[0]["weather"] as! String
        if cur_weatherData != nil
        {
            cell.temLabel.text=cur_weatherData!["temp_curr"] as? String
            cell.temLabel2.text=cur_weatherData!["temperature"] as? String
            cell.weahterLabel1.text=cur_weatherData!["weather"]as? String
            cell.messageImage.image=tool.returnMessageImage(hex: cur_weatherData!["weather"] as! String)
        cell.weahter1.image=tool.returnImageString(hex: cur_weatherData!["weather"] as! String)
        }
        return cell
    }
    var cur_weatherData:NSDictionary?
    var mytable:UITableView?
    var image:UIImageView?
    var btn:UIButton?
    var header=MJRefreshNormalHeader()
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutNavgate(date: tool.returnDateString(date: NSDate()), weekDay: tool.returnWeekDayString(date: NSDate()), city: "三亚")
        downloadData(cityname: "三亚")
        mytable=UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        
        mytable?.mj_header=header
        header.refreshingBlock={
            self.layoutNavgate(date: mytools.returnDateString(date: NSDate()), weekDay: mytools.returnWeekDay(date: NSDate()), city: "南宁")
            self.downloadData(cityname: "南宁")
        }
        let nib=UINib(nibName: "MainTableViewCell", bundle: Bundle.main)
        self.view.addSubview(mytable!)
        mytable?.register(nib, forCellReuseIdentifier: "maincell")
        mytable?.rowHeight=720
        mytable?.delegate=self
        mytable?.dataSource=self
        mytable?.separatorStyle = .none
        mytable?.allowsSelection=false
        //        if #available(iOS 11.0, *) {
        //            mytable!.contentInsetAdjustmentBehavior = .never
        //        } else {
        //            self.automaticallyAdjustsScrollViewInsets = false
        //        }
        
        
        //        if #available(iOS 11.0, *) {
        //            mytable?.contentInsetAdjustmentBehavior = .never
        //            mytable?.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0)//导航栏如果使用系统原生半透明的，top设置为64
        //            mytable?.scrollIndicatorInsets = (mytable?.contentInset)!
        //        }
        
        
        //mytable?.allowsSelection = false
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
                    let indexPath=IndexPath(row: 0, section: 0)
                    let cell=self.mytable?.cellForRow(at: indexPath) as! MainTableViewCell
                    
                    cell.contentView.backgroundColor=tool.retrunweatherColor(weatherType: weatherstr)
                    
                    
                    self.mytable?.backgroundColor=tool.retrunweatherColor(weatherType: weatherstr)
                    self.navigationController?.navigationBar.backgroundColor=tool.retrunweatherColor(weatherType: weatherstr)
                    self.header.endRefreshing()
                   
                }
            }
        }
        datatask.resume()
        let cur_urlstr="http://api.k780.com:88/?app=weather.today&weaid=\(cityname)&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json"
        //下面这句允许url里有中文
        let cur_urlst=cur_urlstr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //把字符串转换成URL格式
        let cur_url=URL(string: cur_urlst!)
        let cur_session=URLSession.shared
        let cur_datatask =   cur_session.dataTask(with: cur_url!) { (data, reponse, error) in
            var jsonstr:NSDictionary?
            
            if data != nil{
                jsonstr=try?
                    JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                self.cur_weatherData=jsonstr!["result"] as! NSDictionary
                
                
                //发送通知
               
                
                DispatchQueue.main.async {
                   
                    self.mytable?.reloadData()
                }
            }
        }
        cur_datatask.resume()
        
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
