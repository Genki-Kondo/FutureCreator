//
//  MailLoginViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/08/01.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import Firebase
import TextFieldEffects
import EMTNeumorphicView
class MailLoginViewController: UIViewController,UITextFieldDelegate {

    var userName:String = ""
    var floatButton = FloatButton()
    let userMailAddress :String? = UserDefaults.standard.object(forKey: "ユーザーメールアドレス") as! String?
    let userPassWord:String? = UserDefaults.standard.object(forKey: "ユーザーパスワード") as! String?
    @IBOutlet var mailTextField: KaedeTextField!
    @IBOutlet var passwordTextField: KaedeTextField!
    @IBOutlet var loginButton: EMTNeumorphicView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate宣言
        mailTextField.delegate = self
        passwordTextField.delegate = self
        //ボタンを浮かせる
        floatButton.changeButton(button: loginButton)
        //ユーザーがアカウントを作成していたらその登録したメールアドレスとパスワードを自動で入れる
        if userMailAddress != "" || userPassWord != ""{
            mailTextField.text = userMailAddress
            passwordTextField.text = userPassWord
        }
        
    }
    //ログインボタンタップで
    @IBAction func login(_ sender: Any) {
        //ユーザー認証
        if let email = mailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    //グローバル変数のログアウトフラグをfalseにする
                    userLogoutFrag = false
                    //ログイン成功を通知するアラート
                    self.successLoginAlert()
                    print("ユーザーがログインしてます")
                    
                }
              
            }
        }
    }
    //ログイン成功を通知するアラートのメソッド
    func successLoginAlert(){
        
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "正常にログインが成功しました", message: "確認ボタンを押しメニューへ", preferredStyle: UIAlertController.Style.actionSheet)
        
        
        // 表示させたいタイトル2ボタンが押された時の処理をクロージャ実装する
        let cancelAction = UIAlertAction(title: "確認", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            //実際の処理
            //メニュー画面へ遷移
            self.dismiss(animated: true, completion: nil)
            print("確認")
            
        })
        //Actionを追加
        actionSheet.addAction(cancelAction)
        
        //iPad対応コード
        actionSheet.popoverPresentationController?.sourceView=self.view
        let screenSize=UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        actionSheet.popoverPresentationController?.sourceRect=CGRect(x:screenSize.size.width/2,y:screenSize.size.height,width:0,height:0)
        //実際にAlertを表示する
        self.present(actionSheet, animated: true, completion: nil)
    }
    //ログインする前に先に新規登録せよというアラートのメソッド
    func alreadyLoginAlert(){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "すでにログインしてます", message: "キャンセルを押して下さい", preferredStyle: UIAlertController.Style.actionSheet)
        
        
        // 表示させたいタイトル2ボタンが押された時の処理をクロージャ実装する
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            //実際の処理
            print("キャンセル")
            
        })
        //Actionを追加
        actionSheet.addAction(cancelAction)
        
        //iPad対応コード
        actionSheet.popoverPresentationController?.sourceView=self.view
        let screenSize=UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        actionSheet.popoverPresentationController?.sourceRect=CGRect(x:screenSize.size.width/2,y:screenSize.size.height,width:0,height:0)
        //実際にAlertを表示する
        self.present(actionSheet, animated: true, completion: nil)
    }
    //タッチでテキストフィールドを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

}
