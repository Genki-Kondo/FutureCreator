//
//  UserInfo.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/08/08.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import Foundation
class UserInfo{
    var likedTitleArray:[String] = [""]
    var likedUrlArray:[String] = [""]
    var totalStudyTime:String = ""
    var launguageStudyTime:String = ""
    init(likedTitleArray:[String],likedUrlArray:[String],totalStudyTime:String,launguageStudyTime:String) {
        self.likedTitleArray = likedTitleArray
        self.likedUrlArray = likedUrlArray
        self.totalStudyTime = totalStudyTime
        self.launguageStudyTime = launguageStudyTime
        
    }
}
