//
//  Dog.swift
//  wangwang
//
//  Created by 郑 宏 on 15/2/26.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import Foundation
import CoreData

class Dog: NSManagedObject {

    @NSManaged var dog_img: String
    @NSManaged var dog_name: String
    @NSManaged var dog_age: NSNumber
    @NSManaged var dog_address: String
    @NSManaged var dog_mes: String
    @NSManaged var dog_time: String
    @NSManaged var dog_flag: NSNumber
    @NSManaged var dog_type: String

}
