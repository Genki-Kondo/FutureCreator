//
//  ConfAndSNSViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/10/11.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import RealmSwift
class ConfAndSNSViewController: UIViewController {
    
    //ラベルの宣言
    @IBOutlet var studyTypeLabel: UILabel!
    @IBOutlet var studyLanguage: UILabel!
    @IBOutlet var studyHours: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realmMigration()
        studyTypeLabel.text = publicStudyType
        studyLanguage.text = publicStudyLaunguage
        studyHours.text = publicStudyHours
        
    }
    //データをカレンダーに保存するメソッド
    func realmAddData(){
        print("データ書き込み開始")
        
        
        
        try! realm.write {
            //日付表示の内容とスケジュール入力の内容が書き込まれる。
            if publicDate.isEmpty == true{
                publicDate = publicNowDate
            }
            
            let study = [Study(value: ["studyType": publicStudyType,"studyLaunguage":publicStudyLaunguage,"studyHours":Double(publicStudyHours),"studyDate":publicDate])]
            realm.add(study)
            print(publicStudyType)
            print(publicNowDate)
            print("データ書き込み中")
        }
        
        print("データ書き込み完了")
    }
    
    //ボタンタップでデータをカレンダーに保存する
    @IBAction func saveOnly(_ sender: Any) {
        finishedSaveAlert()
        //データをカレンダーに保存する
        realmAddData()
    }
    // Realmマイグレーションバージョン
    func realmMigration() {
        // Realmマイグレーションバージョン
        // レコードフォーマットを変更する場合、このバージョンも上げていく。
        let migSchemaVersion: UInt64 = 1

        // マイグレーション設定
        let config = Realm.Configuration(
            schemaVersion: migSchemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < migSchemaVersion) {
        }})
        Realm.Configuration.defaultConfiguration = config
    }
    //ボタンタップでデータ保存しtwitterアラートを出す
    @IBAction func twitterShare(_ sender: Any) {
        //データをカレンダーに保存する
        realmAddData()
        //twitterアラートを出す
        TwitterAlert()
        
    }
    //Twitterを起動して投稿するメソッド
    func twitter(){
        //twitterに投稿したい文章をtextに入れる
               let text = "#" + publicStudyType + " で" + " #" + publicStudyLaunguage + " を学習" + "#" + publicStudyHours + "時間"
        
               //.urlQueryAllowed : URLクエリ内で使用できる文字列で返却する
               guard let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
               guard let twitterURL = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") else {return}
        
               UIApplication.shared.open(twitterURL, options:[:], completionHandler: nil)
    }
    //保存が完了したこと通知するアラート
    func finishedSaveAlert(){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "カレンダーに保存しました", message: "確認を押して下さい", preferredStyle: UIAlertController.Style.actionSheet)
        
        
        // 表示させたいタイトル2ボタンが押された時の処理をクロージャ実装する
        let cancelAction = UIAlertAction(title: "確認", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            //実際の処理
            print("確認")
            
        })
        //Actionを追加
        actionSheet.addAction(cancelAction)
        
        
        //実際にAlertを表示する
        self.present(actionSheet, animated: true, completion: nil)
    }
    //Twitterの起動確認アラートのメソッド
    func TwitterAlert(){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "Twitterを起動してこの記録を投稿しますか？", message: "キャンセルを押すとこの操作を無効にします", preferredStyle: UIAlertController.Style.actionSheet)
        
        // 表示させたいタイトル1ボタンが押された時の処理をクロージャ実装する
        let logoutAction = UIAlertAction(title: "Twitterに投稿", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            
            //実際の処理
            print("Twitterに投稿する")
            //twitterに投稿する
            self.twitter()
            
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
        
        
        //実際にAlertを表示する
        self.present(actionSheet, animated: true, completion: nil)
    }
}
