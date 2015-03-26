//
//  collect.swift
//  wangwang
//
//  Created by 郑 宏 on 15/2/22.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit

let reuseIdentifier = "dogCell"

class collect: UICollectionViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet var collectView: UICollectionView!
    var MJDuration = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 下拉&上拉
        collectionView?.addGifHeaderWithRefreshingTarget(self, refreshingAction: "refresh")
        collectionView?.addGifFooterWithRefreshingTarget(self, refreshingAction: "refresh")
        
        // 设置普通状态的动画图片
        var idleImages = NSMutableArray()
        for i in 1 ... 60 {
            let image = UIImage(named: "dropdown_anim__000\(i)")
            idleImages.addObject(image!)
        }
        self.collectionView?.gifHeader.setImages(idleImages, forState: MJRefreshHeaderStateIdle)
        
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        var refreshingImages = NSMutableArray()
        for i in 1 ... 3 {
            let image = UIImage(named: "dropdown_loading_0\(i)")
            refreshingImages.addObject(image!)
        }
        self.collectionView?.gifHeader.setImages(refreshingImages, forState: MJRefreshHeaderStatePulling)
        
        // 设置正在刷新状态的动画图片
        self.collectionView?.gifHeader.setImages(refreshingImages, forState: MJRefreshHeaderStateRefreshing)
        
    }
    
    func refresh(){
        
        println("refresh start...")
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.collectionView?.header.endRefreshing()
            self.collectionView?.footer.endRefreshing()
        }
    
        println("refresh end...")
    }
    
    func cusAlert(){
        // 添加alert包括 alert与sheet
        var sheet = UIAlertController(title: "sheet", message: "test", preferredStyle: UIAlertControllerStyle.ActionSheet)

        var a1 = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        var a2 = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil)
        var a3 = UIAlertAction(title: "delete", style: UIAlertActionStyle.Destructive, handler: nil)

        sheet.addAction(a1)
        sheet.addAction(a2)
        sheet.addAction(a3)

        self.presentViewController(sheet, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 24
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as cellView
        
        cell.img.image = UIImage(named: "photo-\(indexPath.row +  1).jpg")
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    @IBAction func calcel(sender: AnyObject) {
    }

}
