//
//  mainContainer.swift
//  wangwang
//
//  Created by 郑 宏 on 15/3/5.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit

class mainContainer: UIViewController {

    var blurView = UIImageView()
    var app = UIApplication.sharedApplication().delegate as AppDelegate
    
//    @IBOutlet weak var container: UIView!
    
    @IBAction func gotoLeft(sender: AnyObject) {
        
        updateBlur()
    }
//    @IBAction func backMain(sender: AnyObject) {
//        container.hidden = true
//        
//    }
    
    func updateBlur() {
        
        //为了避免在截图的时候截到选项界面
        //container.hidden = true
        
        //创建一个新的ImageContext来绘制截图，你没有必要去渲染一个完整分辨率的高清截图，使用ImageContext可以节约掉不少的计算量
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 1)
        
        //将界面绘制到ImageContext中去，因为你需要确保选项界面是隐藏状态因此你需要等待屏幕刷新后才能绘制
        self.view.drawViewHierarchyInRect(self.view.bounds, afterScreenUpdates: true)
        
        //将ImageContext放入一个UIImage内然后清理掉这个ImageContext
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        let blur = screenshot.applyLightEffect()

        let iv = UIImageView(image: blur)
        iv.frame = CGRectMake(0, 0, 400, 640)
        view.addSubview(iv)
        //app.showMask(blur)
    
        //container.hidden = false
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
