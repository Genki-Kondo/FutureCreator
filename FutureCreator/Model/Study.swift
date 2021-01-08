//
//  Study.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/10/04.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import Foundation
import RealmSwift

class Study: Object {
    
        
        //学習の種類
        @objc dynamic var studyType: String = ""
        //学習した言語
        @objc dynamic var studyLaunguage: String = ""
        //学習した時間
        @objc dynamic var studyHours: Double = 0.0
//        //日付
        @objc dynamic var studyDate: String = ""
    
}
