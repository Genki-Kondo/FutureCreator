//
//  NameRegisterViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/12/27.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import Firebase
import TextFieldEffects
import EMTNeumorphicView
import Lottie

class NameRegisterViewController: UIViewController,UITextFieldDelegate {

    //端末に保存されたデータ
    var userName :String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
    //AnimationViewの宣言
    var animationView = AnimationView()
    @IBOutlet var registerNameBtn: EMTNeumorphicView!
    @IBOutlet var userNameTextField: KaedeTextField!
    
    @IBOutlet var attentionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addAnimationView()
        userNameTextField.delegate = self
        registerNameBtn.isHidden = true
        attentionLabel.isHidden = true
        //userNameを最初に入力してた場合
        if userName?.isEmpty == false{
            userNameTextField.text = userName
            registerNameBtn.isHidden = false
            attentionLabel.isHidden = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if userNameTextField.text == "" {
            registerNameBtn.isHidden = true
        }else{
            
            registerNameBtn.isHidden = false
        }
    }
    //タップでニックネームを端末に保存する
    @IBAction func registerName(_ sender: Any) {
        let userName = userNameTextField.text
        UserDefaults.standard.set(userName, forKey: "ユーザーネーム")
        
        RegisterAlart()
    }
    
    //テキストフィールドをタップで閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTextField.resignFirstResponder()
        return
    }
    //ゲストユーザーとして始める場合
    @IBAction func guestStart(_ sender: Any) {
//        let randomInt1 = Int.random(in: 0..<9)
//        let randomInt2 = Int.random(in: 0..<9)
//        let randomInt3 = Int.random(in: 0..<9)
//        let randomInt4 = Int.random(in: 0..<9)
//        userNameTextField.text = "ゲストユーザー"+String(randomInt1)+String(randomInt2)+String(randomInt3)+String(randomInt4)
    }
    //テキストフィールドをreturnで閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        userNameTextField.resignFirstResponder()
        return true
    }
    //ニックネーム登録のアラート
    func RegisterAlart(){
        let alert: UIAlertController = UIAlertController(title: "ニックネーム登録完了!!", message: "（新規登録しログインすると全ての機能が使えるようになります）", preferredStyle:  UIAlertController.Style.alert)


            // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
            self.dismiss(animated: true, completion: nil)
            })
       

            // ③ UIAlertControllerにActionを追加
            
            alert.addAction(defaultAction)
        
            // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    //アニメーションの準備
    func addAnimationView() {
        
        //アニメーションファイルの指定
        animationView = AnimationView(name: "registerAnim1")
        
        //アニメーションの位置指定（画面中央）
        animationView.frame = CGRect(x: 0, y: 140, width: view.frame.size.width, height: view.frame.size.height)
        
        //アニメーションのアスペクト比を指定＆ループで開始
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        //ViewControllerに配置
        view.addSubview(animationView)
    }
}
