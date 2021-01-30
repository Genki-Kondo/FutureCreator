//
//  SelectLaunguageViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/10/04.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import EMTNeumorphicView
class SelectLaunguageViewController: UIViewController {

    
    //その他
    @IBOutlet var anotherButton: EMTNeumorphicView!
    @IBOutlet var anotherTextField: UITextField!
    //言語名のボタンの宣言
    @IBOutlet var launguageButton1: EMTNeumorphicView!
    @IBOutlet var launguageButton2: EMTNeumorphicView!
    @IBOutlet var launguageButton3: EMTNeumorphicView!
    @IBOutlet var launguageButton4: EMTNeumorphicView!
    @IBOutlet var launguageButton5: EMTNeumorphicView!
    @IBOutlet var launguageButton6: EMTNeumorphicView!
    @IBOutlet var launguageButton7: EMTNeumorphicView!
    @IBOutlet var launguageButton8: EMTNeumorphicView!
    @IBOutlet var launguageButton9: EMTNeumorphicView!
    @IBOutlet var launguageButton10: EMTNeumorphicView!
    @IBOutlet var launguageButton11: EMTNeumorphicView!
    @IBOutlet var launguageButton12: EMTNeumorphicView!
    @IBOutlet var launguageButton13: EMTNeumorphicView!
    @IBOutlet var launguageButton14: EMTNeumorphicView!
    @IBOutlet var launguageButton15: EMTNeumorphicView!
    
    //FloatButtonクラスをインスタンス化
    var floatButton = FloatButton()
    //の配列の宣言
    var buttonArray :[EMTNeumorphicView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonArray = [launguageButton1,launguageButton2,launguageButton3,launguageButton4,launguageButton5,launguageButton6,launguageButton7,launguageButton8,launguageButton9,launguageButton10,launguageButton11,launguageButton12,launguageButton13,launguageButton14,launguageButton15,anotherButton]
//        //ボタンを浮かせる
//        floatingButton()
    }
    //ボタンを浮かせるメソッド
    func floatingButton(){
        for i in 0..<buttonArray.count{
            floatButton.changeButton(button: buttonArray[i])
        }


    }
    //画面遷移するためのメソッド
    func toNextView(){
        performSegue(withIdentifier: "toTimeView", sender: nil)
    }
    
    @IBAction func selectLaravel(_ sender: Any) {
        publicStudyLaunguage = "Laravel"
        toNextView()
    }
    @IBAction func selectPhp(_ sender: Any) {
        publicStudyLaunguage = "PHP"
        toNextView()
    }
    @IBAction func selectSql(_ sender: Any) {
        publicStudyLaunguage = "SQL"
        toNextView()
    }
    @IBAction func selectPython(_ sender: Any) {
        publicStudyLaunguage = "Python"
        toNextView()
    }
    @IBAction func selectSwift(_ sender: Any) {
        publicStudyLaunguage = "Swift"
        toNextView()
    }
    @IBAction func selectRuby(_ sender: Any) {
        publicStudyLaunguage = "Ruby"
        toNextView()
    }
    @IBAction func selectRails(_ sender: Any) {
        publicStudyLaunguage = "Rails"
        toNextView()
    }
    @IBAction func selectJava(_ sender: Any) {
        publicStudyLaunguage = "Java"
        toNextView()
    }
    @IBAction func selectKotlin(_ sender: Any) {
        publicStudyLaunguage = "Kotlin"
        toNextView()
    }
    @IBAction func selectDjango(_ sender: Any) {
        publicStudyLaunguage = "Django"
        toNextView()
    }
    @IBAction func selectJavaScripts(_ sender: Any) {
        publicStudyLaunguage = "JavaScripts"
        toNextView()
    }
    
    @IBAction func selectNodeJs(_ sender: Any) {
        publicStudyLaunguage = "Node.js"
        toNextView()
    }
    
    @IBAction func selectHtml5Css3(_ sender: Any) {
        publicStudyLaunguage = "HTML/CSS"
        toNextView()
    }
    @IBAction func selectGo(_ sender: Any) {
        publicStudyLaunguage = "GO"
        toNextView()
    }
    @IBAction func selectJquery(_ sender: Any) {
        publicStudyLaunguage = "jQuery"
        toNextView()
    }
    @IBAction func finishAnotherLanguage(_ sender: Any) {
        publicStudyLaunguage = anotherTextField.text!
        toNextView()
    }
    
}
