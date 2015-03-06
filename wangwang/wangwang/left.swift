//
//  left.swift
//  wangwang
//
//  Created by 郑 宏 on 15/3/6.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit

class left: UIViewController {

    @IBOutlet weak var img: UIImageView!
    var imgView = UIImageView()
    var btnT = NSString()
    
    @IBOutlet weak var leftView: UIView!
    
    @IBAction func btn1(sender: AnyObject) {
        btnT = "test1"
    }
    @IBAction func btn2(sender: AnyObject) {
        btnT = "test2"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        img.image = imgView.image
        self.view.bringSubviewToFront(leftView)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    

}
