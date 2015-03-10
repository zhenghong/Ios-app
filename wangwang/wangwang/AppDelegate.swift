//
//  AppDelegate.swift
//  wangwang
//
//  Created by 郑 宏 on 15/2/21.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let tab = self.window?.rootViewController as UITabBarController
        let tabItem = tab.tabBar.items as [UITabBarItem]
        
//        var item1 = tabItem[0]
//        var item2 = tabItem[1]
//        var item3 = tabItem[2]
//        var item4 = tabItem[3]
//    
//        item1.selectedImage = UIImage(named: "bar1on.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        item1.image = UIImage(named: "bar1off.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        item1.badgeValue = "2"
//        item1.title = "狗狗"
//        
//        item2.selectedImage = UIImage(named: "bar3on.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        item2.image = UIImage(named: "bar3off.png")?.imageWithRenderingMode (UIImageRenderingMode.AlwaysOriginal)
//        item2.title = "宠物店"
//        
//        item3.selectedImage = UIImage(named: "bar4on.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        item3.image = UIImage(named: "bar4off.png")?.imageWithRenderingMode (UIImageRenderingMode.AlwaysOriginal)
//        item3.title = "美容"
//        
//        item4.selectedImage = UIImage(named: "bar2on.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        item4.image = UIImage(named: "bar2off.png")?.imageWithRenderingMode (UIImageRenderingMode.AlwaysOriginal)
//        item4.title = "我"
        
        for itemIndex in 0 ... 3 {
            var item = tabItem[itemIndex]
            item.setTitleTextAttributes(NSDictionary(objects: [UIColor.blackColor()], forKeys: [NSForegroundColorAttributeName]), forState: UIControlState.Selected)
            
                item.selectedImage = UIImage(named: "bar\(itemIndex + 1)on.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        }
        
        return true
    }
    
    func showMask(img: UIImage){
        
        let w = window?.frame.width
        let h = window?.frame.height
        
        var maskLayer = CALayer()
        maskLayer.frame = CGRectMake(300, 0, w!-300, h!)
        maskLayer.contents = img.CGImage
        window?.layer.addSublayer(maskLayer)
    }
    
    func unMask(){
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "zh.com.wangwang" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("wangwang", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("wangwang.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}

