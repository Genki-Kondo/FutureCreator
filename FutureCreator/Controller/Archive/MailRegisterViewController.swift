//
//  MailRegisterViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/08/01.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import Firebase
import TextFieldEffects
import EMTNeumorphicView
class MailRegisterViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet var userNameTextField: KaedeTextField!
    @IBOutlet var mailTextField: KaedeTextField!
    @IBOutlet var passwordTextField: KaedeTextField!
    @IBOutlet var registerButton: EMTNeumorphicView!
    
    var userName :String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
    var floatButton = FloatButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate宣言
        userNameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self
        //ボタンを浮かせる
        floatButton.changeButton(button: registerButton)
        if userName?.isEmpty == false{
            userNameTextField.text = userName
        }
    }
    
    //テキストフィールドをタップで閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTextField.resignFirstResponder()
        mailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return
    }
    
    //新しくユーザーを生成
    @IBAction func register(_ sender: Any) {
        //ユーザーを生成
        if let email = mailTextField.text, let password = passwordTextField.text ,let userName = userNameTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    //エラー分をローカルの言語で表示
                    print(e.localizedDescription)
                } else {
                    self.registerAlert()
                    print("新規登録完了")
                    //ユーザー情報をうユーザーの端末に保存する
                   
                    UserDefaults.standard.set(userName, forKey: "ユーザーネーム")
                    UserDefaults.standard.set(email, forKey: "ユーザーメールアドレス")
                    UserDefaults.standard.set(password, forKey: "ユーザーパスワード")
                    
                UserDefaults.standard.set(true, forKey: "アカウント作成フラグ")
                    
                }
            }

        }
    }
    //新規登録完了のアラートのメソッド
    func registerAlert(){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "新規登録が完了しました", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        // 表示させたいタイトル1ボタンが押された時の処理をクロージャ実装する
        let registerAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            
            //iPad対応コード
            actionSheet.popoverPresentationController?.sourceView=self.view
            let screenSize=UIScreen.main.bounds
            // ここで表示位置を調整
            // xは画面中央、yは画面下部になる様に指定
            actionSheet.popoverPresentationController?.sourceRect=CGRect(x:screenSize.size.width/2,y:screenSize.size.height,width:0,height:0)
            // エラーがない場合にはそのままログイン画面に飛び、ログインしてもらう
            self.dismiss(animated: true, completion: nil)
            //            self.performSegue(withIdentifier: "toMailLogin", sender: nil)
            print("新規登録完了")
            
            
        })
        
        //Actionを追加
        actionSheet.addAction(registerAction)
        
        //iPad対応コード
        actionSheet.popoverPresentationController?.sourceView=self.view
        let screenSize=UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        actionSheet.popoverPresentationController?.sourceRect=CGRect(x:screenSize.size.width/2,y:screenSize.size.height,width:0,height:0)
        //実際にAlertを表示する
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}
