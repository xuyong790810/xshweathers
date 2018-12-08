//
//  RightTableViewController.swift
//  celatest1
//
//  Created by 徐勇 on 2018/9/28.
//  Copyright © 2018年 徐勇. All rights reserved.
//

import UIKit

class RightTableViewController: UITableViewController {
var section0title=["提醒","设置","支持"]
var section1title=["添加","定位","南宁","北海","防城港","钦州"]
    var leftimages=["reminder","setting_right","contact"]
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor=UIColor.blue
      let nib=UINib(nibName: "RightTableViewCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: "mycell")
        self.tableView.rowHeight=100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if section==0
       {
        return 3
        }
        else
       {
        return section1title.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! RightTableViewCell
if indexPath.section==0
{
    let imgString:String=leftimages[indexPath.row]
    cell.leftImageview.image=UIImage(named: imgString)
    cell.mylabel.text=section0title[indexPath.row]
    cell.rightimageview.isHidden=true
        }
        else
{
    if indexPath.row==0||indexPath.row==1{
        if indexPath.row==0
        {
            cell.leftImageview.image=UIImage(named: "addcity")
        }
        else
        {
          cell.leftImageview.image=UIImage(named: "city")
        }
        cell.rightimageview.isHidden=true
    }
    else
    {
      cell.leftImageview.image=UIImage(named: "city")
    }
    cell.mylabel.text=section1title[indexPath.row]
        }
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section==0
        {
            let label=UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0))
            
            return label
        }
        else
        {
          let label=UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
            label.text="城市管理"
            label.textAlignment = .center
            return label
        }
    }
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section==1
//        {
//            return "城市管理"
//        }
//        else
//        { return ""}
//    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==1
        {
            return 60
        }
        else
        {
            return 0
        }
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
