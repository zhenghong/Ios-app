//
//  mainContainer.swift
//  wangwang
//
//  Created by 郑 宏 on 15/3/5.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit

class mainContainer: UIViewController {

    var img = UIImageView()
    var app = UIApplication.sharedApplication().delegate as AppDelegate
    
    var left = UIView()
    
    @IBAction func show(sender: AnyObject) {
        
        updateBlur(img)
        img.frame = CGRectMake(0, 0, 400, 600)
        self.view.addSubview(img)
        self.view.addSubview(left)
        aniShow()
    }
    
    func aniShow(){
        
        UIView.beginAnimations("left view show", context: nil)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationDelegate(self)
        
        left.frame = CGRectMake(0, 0, 280, self.view.bounds.height - 40)
        
        UIView.commitAnimations()
    }
    
    func aniDisappear(){
        
        UIView.beginAnimations("left view disappear", context: nil)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationDelegate(self)
        
        left.frame = CGRectMake(-280, 0, 280, self.view.bounds.height - 40)
        
        UIView.commitAnimations()

    }
    
    func updateBlur(blurImg: UIImageView) {
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 1)
        self.view.drawViewHierarchyInRect(self.view.bounds, afterScreenUpdates: true)

        let screenshot = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        let blur = screenshot.applyExtraLightEffect()
  
        blurImg.image = blur
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = NSBundle.mainBundle().loadNibNamed("leftView", owner: self, options: nil)
        left = nib[0] as UIView
        
        left.backgroundColor = UIColor.blueColor()
        left.frame = CGRectMake(-280, 0, 280, self.view.bounds.height - 40)
        left.alpha = 0.5
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnClick(sender: AnyObject) {
        
        let btn = sender as UIButton
        if(btn.currentTitle == "消息"){
            
            self.view.backgroundColor = UIColor.greenColor()
        }else{
            
            self.view.backgroundColor = UIColor.redColor()
        }
        aniDisappear()
        img.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        img.removeFromSuperview()
        left.removeFromSuperview()
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}
