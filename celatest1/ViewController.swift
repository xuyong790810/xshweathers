//
//  ViewController.swift
//  celatest1
//
//  Created by 徐勇 on 2018/9/28.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var leftView:LeftTableViewController?
    var rightView:RightTableViewController?
    var mainVIew:UIViewController?
    var conMove:CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        conMove=0
        let rootCon=MainViewController()
        mainVIew=UINavigationController(rootViewController: rootCon)
        leftView=LeftTableViewController()
        rightView=RightTableViewController()
        rightView?.controllers=mainVIew
        //添加子视图
        
        self.view.addSubview((leftView?.view)!)
        self.view.addSubview((rightView?.view)!)
        self.view.addSubview((mainVIew?.view)!)
        //隐藏左右2⃣️边
        leftView?.view.isHidden=true
        rightView?.view.isHidden=true
        //添加滑动手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        mainVIew?.view.addGestureRecognizer(pan)
        // Do any additional setup after loading the view, typically from a nib.
    }
    // 隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        get{
            return true
        }
       
    }
    @objc func panAction(sender:UIPanGestureRecognizer )
    {
        //获取手指的位置
        let point=sender.translation(in: sender.view)
        conMove=point.x+conMove!
        if (sender.view?.frame.origin.x)! >= CGFloat(0)
        {
            sender.view?.center=CGPoint(x: (sender.view?.center.x)!+point.x, y: (sender.view?.center.y)!)
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            rightView?.view.isHidden=true
            leftView?.view.isHidden=false
        }
        else
        {
            sender.view?.center=CGPoint(x: (sender.view?.center.x)!+point.x, y: (sender.view?.center.y)!)
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            rightView?.view.isHidden=false
            leftView?.view.isHidden=true
        }
        if (sender.state == .ended)
        {showView()}
    }
    func showLeft()
    {
        self.mainVIew?.view.center=CGPoint(x: UIScreen.main.bounds.size.width*1.5-60, y: UIScreen.main.bounds.size.height/2)
    }
    func showRight()
    {
        self.mainVIew?.view.center=CGPoint(x:60-UIScreen.main.bounds.size.width*0.5 , y: UIScreen.main.bounds.size.height/2)
    }
    func showMain()
    {
        self.mainVIew?.view.center=CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
    }
    func showView()
    {
        if (conMove! >= UIScreen.main.bounds.size.width/2) {
            showLeft()
        }
        else if (conMove! <= -UIScreen.main.bounds.size.width/2)
        {
            showRight()
        }
        else
        {
            showMain()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

