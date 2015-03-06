//
//  mainContainer.swift
//  wangwang
//
//  Created by 郑 宏 on 15/3/5.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit

class mainContainer: UIViewController {


    @IBOutlet weak var img: UIImageView!
    var app = UIApplication.sharedApplication().delegate as AppDelegate
    
    func updateBlur(blurImg: UIImageView) {
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 1)
        self.view.drawViewHierarchyInRect(self.view.bounds, afterScreenUpdates: true)

        let screenshot = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        let blur = screenshot.applyDarkEffect()
  
        blurImg.image = blur
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let des = segue.destinationViewController as left
        updateBlur(des.imgView)
    }
    
    @IBAction func back(segue: UIStoryboardSegue, sender: AnyObject?){
        
        let btnVc = segue.sourceViewController as left
        
        let title = btnVc.btnT
        if(title == "test1"){
            img.image = UIImage(named: "photo-15.jpg")
        } else if(title == "test2") {
            img.image = UIImage(named: "photo-16.jpg")
        } else {
            img.image = UIImage(named: "photo-17.jpg")
        }
    }
    
}
