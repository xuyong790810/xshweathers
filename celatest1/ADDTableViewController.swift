//
//  ADDTableViewController.swift
//  celatest1
//
//  Created by 徐勇 on 2018/12/21.
//  Copyright © 2018 徐勇. All rights reserved.
//

import UIKit

class ADDTableViewController: UITableViewController {
    var cityArray=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.black
        let path=Bundle.main.path(forResource: "default-city", ofType: "plist")
        cityArray=NSArray(contentsOfFile: path!) as! Array
        self.tableView.backgroundColor=UIColor.black
        let nib=UINib(nibName: "ADDTableViewCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: "mycell")
        let headerView=UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        headerView.backgroundColor=UIColor.black
        let search_tf=UITextField(frame: CGRect(x: 20, y: 14, width: self.view.frame.size.width-40, height: 30))
        search_tf.backgroundColor=UIColor.white
        search_tf.layer.cornerRadius=15
        search_tf.placeholder="城市名称或拼音"
        search_tf.leftView=UIImageView(image: UIImage(named: "search_b"))
        //search_tf.layer.masksToBounds=true
        search_tf.leftViewMode = .always
        headerView.addSubview(search_tf)
        self.tableView.separatorStyle = .none
        self.tableView.tableHeaderView=headerView
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityArray.count+1
    }
//    override var prefersStatusBarHidden: Bool{
//        get{
//            return true
//        }
//
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
       
        //定义header里的输入框
        if indexPath.row==0
        {
            
        cell.textLabel?.text="自动定位"
            cell.textLabel?.textColor=UIColor.white
        cell.imageView?.image = UIImage(named: "city")
        }
       
        else
        {
            cell.textLabel?.text=cityArray[indexPath.row-1]
            cell.textLabel?.textColor=UIColor.white
            cell.imageView?.image=nil
        }
        // Configure the cell...
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==0
        {
            NotificationCenter.default.post(name: NSNotification.Name(AutoLocationNotification), object: nil)
        }
        else
        {
           let city=cityArray[indexPath.row-1] as! String
            NotificationCenter.default.post(name: NSNotification.Name(chooseCityLocationNotification), object: nil, userInfo: ["chooseCity":city])
            helper.insertCity(city: city)
        }
        self.dismiss(animated: true, completion: nil)
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
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
