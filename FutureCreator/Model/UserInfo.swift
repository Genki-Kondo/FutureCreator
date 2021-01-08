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
    init(likedTitleArray:[String],likedUrlArray:[String]) {
        self.likedTitleArray = likedTitleArray
        self.likedUrlArray = likedUrlArray
        
    }
}
