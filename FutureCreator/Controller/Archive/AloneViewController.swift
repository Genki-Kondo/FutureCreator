//
//  AloneViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/20.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import EMTNeumorphicView
class AloneViewController: UIViewController,UITextFieldDelegate {
    
    //ボタンがタップされたか判断するフラグ
    var buttonFrag = false
    var floatButton = FloatButton()
    
    @IBOutlet var languageButton: UIButton!
    
    @IBOutlet var anotherTextField: UITextField!
    
    @IBOutlet var alone1Button: EMTNeumorphicView!
    @IBOutlet var alone2Button: EMTNeumorphicView!
    @IBOutlet var alone3Button: EMTNeumorphicView!
    @IBOutlet var alone4Button: EMTNeumorphicView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //languageButtonを隠す
        languageButton.isHidden = true
        
        anotherTextField.delegate = self
        //ボタンを浮かせる
        floatingButton()
        
    }
    //ボタンを浮かせるメソッド
    func floatingButton(){
        floatButton.changeButton(button: alone1Button)
        floatButton.changeButton(button: alone2Button)
        floatButton.changeButton(button: alone3Button)
        floatButton.changeButton(button: alone4Button)

    }
    
    
    //画面遷移
    @IBAction func toLanguageView(_ sender: Any) {
        performSegue(withIdentifier: "toLanguageView", sender: nil)
    }
    //textFieldを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        anotherTextField.resignFirstResponder()
    }
    
    //textFieldを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.anotherTextField.resignFirstResponder()
    }
    //textFieldに文字が記入されるか勉強方法を選択するとボタンが出現
    func textFieldDidEndEditing(_ textField: UITextField) {
        if anotherTextField.text == "" {
            languageButton.isHidden = true
        }else if anotherTextField.text != nil {
            languageButton.isHidden = false
        }
        
    }
    @IBAction func selectUdemy(_ sender: UIButton) {
        //タップでlanguageButtonが出現
        languageButton.isHidden = false
        
        
    }
    @IBAction func selectProgate(_ sender: Any) {
        //タップでlanguageButtonが出現
        languageButton.isHidden = false
        
    }
    @IBAction func selectTextBook(_ sender: Any) {
        //タップでlanguageButtonが出現
        languageButton.isHidden = false
        
    }
    @IBAction func selectDotinstall(_ sender: Any) {
        //タップでlanguageButtonが出現
        languageButton.isHidden = false
        
    }
    

}
