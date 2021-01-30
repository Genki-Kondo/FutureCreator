//
//  SearchTabViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/12/26.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit

class SearchTabBarController: UITabBarController,UITabBarControllerDelegate {

    var userName :String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userName)
//        setupTab()
        self.tabBarController?.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userDefaults = UserDefaults.standard
        let firstLunchKey = "firstLunchKey"
        if userDefaults.bool(forKey: firstLunchKey) == true{
            userDefaults.set(false, forKey: firstLunchKey)
//            print("toNameRegister")
//            if userName?.isEmpty == false{
//                print(userName)
//            }else{
//                performSegue(withIdentifier: "toNameRegister", sender: nil)
//            }
            
            
            
        }
    }
    //タブバーをタップ時の反応
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//            if viewController == tabBarController.viewControllers?[0] {
//                performSegue(withIdentifier: "toMailRegister", sender: nil)
//                return false
//            }
//            return true
//        }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 2:
            print("テスト")
            if userName == ""{
                pleaseRegisterAlart()
            }
            
            
        default: break
            
            
        }
    }
    func setupTab() {
            delegate = self  // delegateを設定
            let SearchVC = SearchViewController()
        SearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
            let likedVC = likedViewController()
        likedVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 3)
            viewControllers = [SearchVC, likedVC]
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

}
