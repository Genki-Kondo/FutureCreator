//
//  FloatButton.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/20.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import Foundation
import EMTNeumorphicView

class FloatButton {
    
    var button = EMTNeumorphicView()
    //ボタンを浮き上がらせるためのメソッド
    func changeButton(button:EMTNeumorphicView){
        button.layer.cornerRadius = 20
        button.neumorphicLayer?.depthType = .convex
        button.neumorphicLayer?.elementDepth = 10
        button.neumorphicLayer?.cornerType = .all
    }
    
    
}
