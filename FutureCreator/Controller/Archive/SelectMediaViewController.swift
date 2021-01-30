//
//  SelectMediaViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/09/22.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import EMTNeumorphicView
import RealmSwift
class SelectMediaViewController: UIViewController {
    
    
    //その他ボタン
    @IBOutlet var anotherButton: EMTNeumorphicView!
    @IBOutlet var anotherTextField: UITextField!
    //学習媒体のボタンの宣言
    @IBOutlet var mediaButton1: EMTNeumorphicView!
    @IBOutlet var mediaButton2: EMTNeumorphicView!
    @IBOutlet var mediaButton3: EMTNeumorphicView!
    @IBOutlet var mediaButton4: EMTNeumorphicView!
    @IBOutlet var mediaButton5: EMTNeumorphicView!
    @IBOutlet var mediaButton6: EMTNeumorphicView!
    
    //FloatButtonクラスをインスタンス化
    var floatButton = FloatButton()
    //配列の宣言
    var buttonArray :[EMTNeumorphicView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonArray = [mediaButton1,mediaButton2,mediaButton3,mediaButton4,mediaButton5,mediaButton6,anotherButton]
        floatingButton()
        
    }
    //ボタンを浮かせるメソッド
    func floatingButton(){
        for i in 0..<buttonArray.count{
            floatButton.changeButton(button: buttonArray[i])
        }
    }
    //次のviewに画面遷移
    func nextView(){
        performSegue(withIdentifier: "toSelectAttribute", sender: nil)
    }
    
    @IBAction func selectUdemy(_ sender: Any) {
        publicStudyType = "Udemy"
        nextView()
    }
    @IBAction func selectProgate(_ sender: Any) {
        publicStudyType = "プロゲート"
        nextView()
    }
    
    @IBAction func selectTechAcademy(_ sender: Any) {
        publicStudyType = "TechAcademy"
        nextView()
    }
    @IBAction func selectCodeCamp(_ sender: Any) {
        publicStudyType = "CodeCamp"
        nextView()
    }
    @IBAction func selectDayTry(_ sender: Any) {
        publicStudyType = "デイトラ"
        nextView()
    }
    
    @IBAction func selectHacksSeries(_ sender: Any) {
        publicStudyType = "Hacksシリーズ"
        nextView()
    }
 
    
    @IBAction func finishAnotherMedia(_ sender: Any) {
        publicStudyType = anotherTextField.text!
        nextView()
    }
    
}
