//
//  MenuViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/28.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
//グローバル変数でユーザーのログアウト判定のフラグ
var userLogoutFrag:Bool = false
var userCreateAccountFrag:Bool = false

class MenuViewController: UIViewController {
    
    
    
    @IBOutlet var useStatusLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var menuView: UIView!
    @IBOutlet var mailLoginButton: UIButton!
    
    @IBOutlet var mailRegisterButton: UIButton!
    
    @IBOutlet var howToUseButton: UIButton!
    //端末に保存されたデータを変数に格納
    let userName :String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
    let userCreateAccount :Bool? = UserDefaults.standard.bool(forKey: "アカウント作成フラグ") as! Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if Auth.auth().currentUser != nil {
            //ユーザーがサインインしてる場合
            userNameLabel.text = userName
            useStatusLabel.text = "でログイン中"
            print(userName! + "がサインインしてる")
        } else if Auth.auth().currentUser == nil {
            //ユーザーがサインインしてない場合
            userNameLabel.text = "ログアウト中"

            
        }
        // メニューの位置を取得する
        let menuPos = self.menuView.layer.position
        // 初期位置を画面の外側にするため、メニューの幅の分だけマイナスする
        self.menuView.layer.position.x = -self.menuView.frame.width
        // 表示時のアニメーションを作成する
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.menuView.layer.position.x = menuPos.x
            },
            completion: { bool in
            })
        
    }
    
    // メニューエリア以外タップ時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.menuView.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )
            }
        }
    }
    
    //メールアドレスで登録
    @IBAction func mailRegister(_ sender: Any) {
        registerJudge()
        
        performSegue(withIdentifier: "toMailRegister", sender: nil)
        
    }

    //メールでログインする
    @IBAction func mailLogin(_ sender: Any) {
        loginJudge()
        performSegue(withIdentifier: "toMailLogin", sender: nil)
    }
    //ログアウトする
    @IBAction func logout(_ sender: Any) {
        if userLogoutFrag == true{
            //すでにログアウト済みというアラート
            alreadyLogoutAlert()
        }
        //ログアウトの確認アラート
        logoutAlert()
    }
    //全データ削除の確認アラートのメソッド
    func allDeleteAlert(){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "本当に全ての学習記録を削除しますか？", message: "キャンセルを押すとデータ削除を無効にします", preferredStyle: UIAlertController.Style.actionSheet)
        
        // 表示させたいタイトル1ボタンが押された時の処理をクロージャ実装する
        let logoutAction = UIAlertAction(title: "全データ削除", style: UIAlertAction.Style.default, handler: { [self]
            (action: UIAlertAction!) in
            
            //実際の処理
            //全てデータ削除する
            self.deleteData()
            print("データ削除")
            
        })
        // 表示させたいタイトル2ボタンが押された時の処理をクロージャ実装する
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            //実際の処理
            self.dismiss(animated: true, completion: nil)
            print("キャンセル")
            
            
        })
        //Actionを追加
        actionSheet.addAction(logoutAction)
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
    //ログアウトの確認アラートのメソッド
    func logoutAlert(){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "本当にログアウトしますか？", message: "キャンセルを押すとログアウトを無効にします", preferredStyle: UIAlertController.Style.actionSheet)
        
        // 表示させたいタイトル1ボタンが押された時の処理をクロージャ実装する
        let logoutAction = UIAlertAction(title: "ログアウト", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            //フラグをログアウトする
            userLogoutFrag = true
            //実際の処理
            print("ログアウト")
            //ログアウトする
            self.userLogout()
        })
        // 表示させたいタイトル2ボタンが押された時の処理をクロージャ実装する
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            //実際の処理
            self.dismiss(animated: true, completion: nil)
            print("キャンセル")
            
            
        })
        //Actionを追加
        actionSheet.addAction(logoutAction)
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
    //すでにログイン済みというアラートのメソッド
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
    //ログアウトする為のメソッド
    func userLogout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    //すでにログアウト済みというアラートのメソッド
    func alreadyLogoutAlert(){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "すでにログアウトしてます", message: "キャンセルを押して下さい", preferredStyle: UIAlertController.Style.actionSheet)
        
        
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
    //すでに１つのアカウント登録ず済みというアラートのメソッド
    func alreadyCreateAccountAlert(){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "１つの端末で１つのアカウントしか登録できません", message: "キャンセルを押して下さい", preferredStyle: UIAlertController.Style.actionSheet)
        
        
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
    //先に登録のアラート
    func pleaseRegisterAlart(){
        let alert: UIAlertController = UIAlertController(title: "最初に新規登録をしてください。", message: "（新規登録しログインすると全ての機能が使えるようになります）下の新規登録ボタンをクリックしましょう！！", preferredStyle:  UIAlertController.Style.alert)


            // 新規登録ボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "新規登録", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "toMailRegister", sender: nil)
            })
            // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("Cancel")
            })

            // ③ UIAlertControllerにActionを追加
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
        
        
            // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    //ユーザーがログインしてるか判定する為のメソッド
    func loginJudge(){
        
        
        if Auth.auth().currentUser != nil {
            //ユーザーがサインインしてる場合
            alreadyLoginAlert()
            print("ユーザーがサインインしてる")
        } else {
            //ユーザーがサインインしてない場合
            if userCreateAccount! == false {
                //ユーザーがサインインしてる場合
                pleaseRegisterAlart()
                print("ユーザーがサインインしてる")
            }
            print("ユーザーがログアウトしてる")
            
        }
    }
    //ユーザーが新規登録してるか判定する為のメソッド
    func registerJudge(){
        
        
        if userCreateAccount! == true {
            //ユーザーがサインインしてる場合
            alreadyCreateAccountAlert()
            print("ユーザーがサインインしてる")
        } else {
            //ユーザーがサインインしてない場合
            print("ユーザーがログアウトしてる")
            
        }
    }
    
    
    @IBAction func allDelete(_ sender: Any) {
        allDeleteAlert()
        
        
    }
    //全てデータ削除するメソッド
    func deleteData(){
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        
        let realmURLs = [
            
            realmURL,
            
            realmURL.appendingPathExtension("lock"),
            
            realmURL.appendingPathExtension("note"),
            
            realmURL.appendingPathExtension("management")
            
        ]
        
        for URL in realmURLs {
            
            do {
                
                try FileManager.default.removeItem(at: URL)
            } catch {
                print("エラー")
                
            }
        }
        
        // ファイルは残すが、中身を空っぽに
        try! realm.write {
            realm.deleteAll()
            print("全てのデータを削除した")
        }
    }
    //HowToViewに画面遷移する
    @IBAction func toHowToView(_ sender: Any) {
        performSegue(withIdentifier: "toHowToView", sender: nil)
    }
    
}
