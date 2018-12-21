//
//  MainViewController.swift
//  celatest1
//
//  Created by 徐勇 on 2018/9/28.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit
import CoreLocation
class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    
    var cur_weatherData:NSDictionary?
    var mytable:UITableView?
    var image:UIImageView?
    var btn:UIButton?
    var header=MJRefreshNormalHeader()
    //拿到位置的经纬度
    var locationManager:CLLocationManager?
    //根据经纬度解析地名
    var geocoder=CLGeocoder()
    var city:String?
    var hud:MBProgressHUD!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.black
        //定位前的动画
        hud=MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text="正在定位中...."
        location()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "maincell") as! MainTableViewCell
        // cell.weahterLabel1.text=dataSource[0]["weather"] as! String
        print("1111")
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
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count>0
        {
            locationManager?.stopUpdatingLocation()
            let locationInfo=locations.last
            
            geocoder.reverseGeocodeLocation(locationInfo!, completionHandler: { (placeMark, error) in
                //强制转成简体中文
                let array = NSArray(object: "zh-hans")
                UserDefaults.standard.set(array, forKey: "AppleLanguages")
                //print(placeMark!)
                if (placeMark?.count)! > 0
                {
                     self.hud.label.text="已经定位成功，读取数据中"
                    let placeM=placeMark![0]
                    var mycity=placeM.locality
                    if (mycity?.contains("市"))!
                    {
                        // let rang = (mycity! as! NSString).range(of: "市")
                        mycity?.removeLast()
                    }
                    self.city=mycity
                    DispatchQueue.main.async {
                        self.initView()
                    }
                    
                }
            })
        }
    }
    func location()
    {
        
        if CLLocationManager.locationServicesEnabled()==false
        {
            print("定位未打开")
        }
        else
        {
            
            locationManager=CLLocationManager()
            locationManager?.requestWhenInUseAuthorization()
        }
        locationManager?.delegate=self
        locationManager?.startUpdatingLocation()
        
        
        
    }
    func initView()
    {
        
        downloadData(cityname: city!)
        layoutNavgate(date: tool.returnDateString(date: NSDate()), weekDay: tool.returnWeekDayString(date: NSDate()), city: city!)
        if mytable==nil
        {
        mytable=UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        
        mytable?.mj_header=header
        header.refreshingBlock={
            self.layoutNavgate(date: mytools.returnDateString(date: NSDate()), weekDay: mytools.returnWeekDay(date: NSDate()), city: self.city!)
            self.downloadData(cityname: self.city!)
        }
        let nib=UINib(nibName: "MainTableViewCell", bundle: Bundle.main)
        
        mytable?.register(nib, forCellReuseIdentifier: "maincell")
        mytable?.rowHeight=720
        mytable?.delegate=self
        mytable?.dataSource=self
        mytable?.separatorStyle = .none
        self.mytable?.isHidden = true
        mytable?.allowsSelection=false
        self.view.addSubview(mytable!)
            sleep(1)
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
                    let indexPath=IndexPath(row: 0, section: 0)
                    let cell=self.mytable?.cellForRow(at: indexPath) as! MainTableViewCell
                    cell.contentView.backgroundColor=tool.retrunweatherColor(weatherType: weatherstr)
                    self.mytable?.backgroundColor=tool.retrunweatherColor(weatherType: weatherstr)
                    self.navigationController?.navigationBar.backgroundColor=tool.retrunweatherColor(weatherType: weatherstr)
                    self.mytable?.reloadData()
                    self.mytable?.isHidden=false
                    self.header.endRefreshing()
                   
                }
            }
        }
        datatask.resume()
        //取到当天的天气
                let cur_urlstr="http://api.k780.com:88/?app=weather.today&weaid=\(cityname)&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json"
                //下面这句允许url里有中文
                let cur_urlst=cur_urlstr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                //把字符串转换成URL格式
                let cur_url=URL(string: cur_urlst!)
                let cur_session=URLSession.shared
                let cur_datatask =   cur_session.dataTask(with: cur_url!) { (data, reponse, error) in
                    var jsonstr:NSDictionary?
                    //print(data)
                    if data != nil{
                        jsonstr=try?
                            JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                        self.cur_weatherData=jsonstr!["result"] as! NSDictionary
        
       
                        
        
        
                        DispatchQueue.main.async {
        self.hud.hide(animated: true)
                            self.mytable?.reloadData()
                        }
                    }
                }
                cur_datatask.resume()
        
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
