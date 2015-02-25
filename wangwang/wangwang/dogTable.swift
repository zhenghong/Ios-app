//
//  dogTable.swift
//  wangwang
//
//  Created by 郑 宏 on 15/2/22.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit

var dogArry = NSMutableArray()

class dogTable: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var table: UITableView!
    
    func initDogs(){
        var dog: dogData
        dog = dogData(img: "photo-1.jpg",name: "果果",age: 2,
            mes: "白羊座，因为出差需要寄养几天，详细请联系郑宏 15801234157",
            address: "北京，通州",time: "10:00",flag: 0,type: "泰迪")
        dogArry.addObject(dog)
        dog = dogData(img: "photo-2.jpg",name: "豆豆",age: 3,
            mes: "白羊座，因为出差需要寄养几天，详细请联系郑宏 15801234157",
            address: "北京，酒仙桥",time: "2:00",flag: 1,type: "哈士奇")
        dogArry.addObject(dog)
        dog = dogData(img: "photo-3.jpg",name: "闹闹",age: 5,
            mes: "白羊座，因为出差需要寄养几天，详细请联系郑宏 15801234157",
            address: "上海，浦东",time: "昨天",flag: 0,type: "松狮")
        dogArry.addObject(dog)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDogs()
        
        
        //初始化UIRefreshControl
        var rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "下拉刷新")
        rc.addTarget(self, action: "refreshDogs", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = rc
        self.table.addSubview(refreshControl)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refreshDogs(){
        
        if (self.refreshControl.refreshing) {
            self.refreshControl.attributedTitle = NSAttributedString(string: "加载中...")
        }
    }
    
    func callBackMethod(){
        self.refreshControl.endRefreshing()
        self.refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dogArry.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dogTableCell", forIndexPath: indexPath) as dogTableCell
        
        let dog =  dogArry[indexPath.row] as dogData
        
        cell.img.image = UIImage(named: dog.dog_img)
        cell.name.text = dog.dog_name
        cell.age.text = "\(dog.dog_age)"
        cell.address.text = dog.dog_address
        cell.type.text = dog.dog_type
        cell.time.text = dog.dog_time
        cell.mes.text = dog.dog_mes
        if(dog.dog_flag == 1){
            cell.flag.titleLabel?.text = "包养"
        } else {
            cell.flag.titleLabel?.text = "寄宿"
        }
        
        // Configure the cell...

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("gotoDogImg", sender: nil)
       
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.identifier == "gotoDogImg") {

        }
    }
    
    
    @IBAction func cancel(segue: UIStoryboardSegue, sender: AnyObject?){
    
    }

}
