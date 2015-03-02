//
//  addDog.swift
//  wangwang
//
//  Created by 郑 宏 on 15/2/26.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit
import CoreData

class addDog: UIViewController,UITextFieldDelegate {
    

    @IBOutlet weak var img: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var flag: UISwitch!
    @IBOutlet weak var mes: UITextView!
    
    @IBAction func keyR(sender: AnyObject) {
        
        img.resignFirstResponder()
        name.resignFirstResponder()
        age.resignFirstResponder()
        address.resignFirstResponder()
        type.resignFirstResponder()
        mes.resignFirstResponder()
    }
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    func textFieldDidBeginEditing(textField: UITextField) {
        
        var frame = textField.frame
        let offset = frame.origin.y + 72 - (self.view.frame.size.height - 216)
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(0.3)
        if(offset > 0){
            self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }
        UIView.commitAnimations()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {	return managedObjectContext
        }
        else {
            return nil
        }
    }()
    
    func getSysTime() -> NSString{
        
        var date = NSDate()
        var timeFormatter = NSDateFormatter()
        //timeFormatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss.SSS"
        timeFormatter.dateFormat = "HH:mm"
        var strNowTime = timeFormatter.stringFromDate(date) as String
        return strNowTime
    }
    

    @IBAction func add(sender: AnyObject) {
        
        var dog = NSEntityDescription.insertNewObjectForEntityForName("Dog", inManagedObjectContext: self.managedObjectContext!) as Dog
        
        dog.dog_img = self.img.text
        dog.dog_name = self.name.text
        dog.dog_mes = self.mes.text
        if(self.flag.on){
            dog.dog_flag = 0
        } else {
            dog.dog_flag = 1
        }
        dog.dog_time = getSysTime()
        dog.dog_address = self.address.text
        dog.dog_type = self.type.text
        dog.dog_age = self.age.text.toInt()!
        
        self.managedObjectContext?.save(nil)
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
        add(sender!)
    }
    

}
