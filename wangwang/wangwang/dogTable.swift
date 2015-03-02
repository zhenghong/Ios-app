//
//  dogTable.swift
//  wangwang
//
//  Created by 郑 宏 on 15/2/22.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit
import CoreData

class dogTable: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    var dogArry = NSMutableArray()
    var refreshControl = UIRefreshControl()
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {	return managedObjectContext
        }
        else {
            return nil
        }
    }()
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //print("searchText="+searchText)
        queryCon(searchText)
        table.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func queryDogs(){
        queryCon("")
    }
    
    func queryCon(name: NSString){
        
        var error: NSError? = nil
        //SQL :from
        var select: NSFetchRequest = NSFetchRequest(entityName: "Dog")
        //SQL:where条件查询
        if(name != ""){
            select.predicate = NSPredicate(format: "dog_name='\(name)'")
        }
        //SQL:orderby排序  倒序
        let sortDescriptor = NSSortDescriptor(key: "dog_name", ascending: true)
        select.sortDescriptors = [sortDescriptor]
        var result = self.managedObjectContext!.executeFetchRequest(select,error:&error) as [Dog]
        
        dogArry.removeAllObjects()
        for dog: Dog in result{
            //println("dogName:\(dog.dog_name) ,dogAge:\(dog.dog_age)")
            self.dogArry.addObject(dog)
        }
    }
    
    func del(name: NSString){
        
        var error: NSError? = nil
        var select: NSFetchRequest=NSFetchRequest(entityName: "Dog")
        select.predicate = NSPredicate(format: "dog_name='\(name)'")
        var result = self.managedObjectContext!.executeFetchRequest(select,error:&error) as [Dog]
        
        for dog: Dog in result{
            self.managedObjectContext!.deleteObject(dog)
        }
        
        self.managedObjectContext?.save(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queryDogs()
        
        //初始化UIRefreshControl
        var rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "下拉刷新")
        rc.addTarget(self, action: "refreshDogs", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = rc
        self.table.addSubview(refreshControl)

        //初始化编辑按钮
        self.editButtonItem().title = "编辑"
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
    }
    
    // MARK: - RefreshControl
    func refreshDogs(){
        
        if (self.refreshControl.refreshing) {
            self.refreshControl.attributedTitle = NSAttributedString(string: "加载中...")
        }
    }
    
    //下拉回调
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

    override func setEditing(editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: true)
        self.table.setEditing(editing, animated: true)
        if(self.editing){
            self.editButtonItem().title = "完成"
        } else {
            self.editButtonItem().title = "编辑"
        }
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            
            //删除数据
            let dog = dogArry[indexPath.row] as Dog
            dogArry.removeObjectAtIndex(indexPath.row)
            del(dog.dog_name)
            
            //删除表格
            table.deleteRowsAtIndexPaths(NSArray(object: indexPath), withRowAnimation: UITableViewRowAnimation.Bottom)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dogTableCell", forIndexPath: indexPath) as dogTableCell
        
        let dog =  dogArry[indexPath.row] as Dog
        
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
        
        let dogVoew = segue.sourceViewController as addDog
        
        queryDogs()
        self.table.reloadData()
    }

}
