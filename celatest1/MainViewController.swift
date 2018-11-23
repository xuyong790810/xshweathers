//
//  MainViewController.swift
//  celatest1
//
//  Created by 徐勇 on 2018/9/28.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var image:UIImageView?
    var btn:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title="我的天气app"
        self.view.backgroundColor=UIColor.purple
       //layoutNavgate(date: "3-11", weekDay: "周二", city: "北海")
        layoutNavgate(date:Tools.returnDateString(date: NSDate()), weekDay: "周一", city: "南宁")
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
//    func layoutNavigate(date:String,weekDay:String,cityName:String)
//  {
//    self.navigationController?.navigationBar.tintColor=UIColor.white
//    let catogryBarItem=UIBarButtonItem(image: UIImage(named: "category_hover"), style: .plain, target: self, action: #selector(chooseDateAction))
//    let dateBarItem=UIBarButtonItem(title: date+"/"+weekDay, style: .plain, target: self, action: #selector(chooseDateAction))
//    self.navigationItem.leftBarButtonItems=[catogryBarItem,dateBarItem]
//    }
//  @objc  func chooseDateAction(){
//
//    }
    @objc func downloadData()
    {
        let url:URL=URL(string: "http://api.k780.com:88/?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")!
        let session=URLSession.shared
        let datatask =   session.dataTask(with: url) { (data, reponse, error) in
            let jsonstr=try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
       let weathers = jsonstr!["result"] as! NSArray
           let weather=weathers[0] as! NSDictionary
            let weatherstr=weather["weather"] as! String
            print(weatherstr)
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
