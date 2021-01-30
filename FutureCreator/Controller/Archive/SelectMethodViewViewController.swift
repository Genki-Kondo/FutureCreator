//
//  MethodViewViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/20.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import EMTNeumorphicView


class SelectMethodViewViewController: UIViewController {

    
    @IBOutlet var progSchoolButton: EMTNeumorphicView!
    @IBOutlet var aloneButton: EMTNeumorphicView!
    var floatButton = FloatButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ボタンを浮かせる
        changeButton()
        
    }
    //ボタンを浮かせるメソッド
    func changeButton(){
        floatButton.changeButton(button: progSchoolButton)
        floatButton.changeButton(button: aloneButton)
    }
    //画面遷移
    @IBAction func toSchoolView(_ sender: Any) {
        
        publicStudyMethod = "オフライン学習"
        performSegue(withIdentifier: "toOfflineView", sender: nil)
        
    }

    //画面遷移
    @IBAction func toAloneView(_ sender: Any) {
        
        publicStudyMethod = "オンライン学習/独学"
        performSegue(withIdentifier: "toOnlineView", sender: nil)
    }
    
}
