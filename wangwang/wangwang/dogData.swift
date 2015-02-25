//
//  dogData.swift
//  wangwang
//
//  Created by 郑 宏 on 15/2/22.
//  Copyright (c) 2015年 zh.com. All rights reserved.
//

import Foundation

class dogData {
    
    let dog_img: NSString
    let dog_name: NSString
    let dog_age: NSNumber
    let dog_address: NSString
    let dog_mes: NSString
    let dog_time: NSString
    let dog_flag: NSNumber
    let dog_type: NSString
    
    init(img: NSString,name: NSString,age: NSNumber,mes: NSString,
        address: NSString,time: NSString,flag: NSNumber,type: NSString){
            
            dog_img = img
            dog_name = name
            dog_age = age
            dog_mes = mes
            dog_address = address
            dog_time = time
            dog_flag = flag
            dog_type = type
            
    }
}