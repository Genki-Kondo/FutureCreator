//
//  EventViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/09/20.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import RealmSwift
import EMTNeumorphicView
//ディスプレイサイズ取得
let w2 = UIScreen.main.bounds.size.width
let h2 = UIScreen.main.bounds.size.height


class EventViewController: UIViewController,UITextViewDelegate {
    
    var floatButton = FloatButton()
    @IBOutlet var SaveButton: EMTNeumorphicView!
    //スケジュール内容入力テキスト
    @IBOutlet var eventText: UITextView!
    //日付フォーム(UIDatePickerを使用)
    @IBOutlet var datePicker: UIDatePicker!
    //日付表示
    @IBOutlet var showDateText: UILabel!
    let formatter = DateFormatter()
    var calenderTime = ""
    var date: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタンを浮かせる
        floatButton.changeButton(button: SaveButton)
        //スケジュール内容入力テキストView設定
        eventText.text = ""
        eventText.layer.borderColor = UIColor.gray.cgColor
        eventText.layer.borderWidth = 1.0
        eventText.layer.cornerRadius = 10.0
        let custombar = UIView(frame: CGRect(x:0, y:0,width:(UIScreen.main.bounds.size.width),height:40))
        custombar.backgroundColor = UIColor.groupTableViewBackground
        let commitBtn = UIButton(frame: CGRect(x:(UIScreen.main.bounds.size.width)-60,y:0,width:50,height:40))
        commitBtn.setTitle("完了", for: .normal)
        commitBtn.setTitleColor(UIColor.blue, for:.normal)
        commitBtn.addTarget(self, action:#selector(EventViewController.onClickCommitButton), for: .touchUpInside)
        custombar.addSubview(commitBtn)
        eventText.inputAccessoryView = custombar
        eventText.keyboardType = .default
        eventText.delegate = self
        
        
        //日付フォーム設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        //日付表示設定
        showDateText.text = calenderTime
        showDateText.backgroundColor = .white
        showDateText.textAlignment = .center
        
    }
    //TextViewに完了ボタンを設定
    @objc func onClickCommitButton (sender: UIButton) {
        if(eventText.isFirstResponder){
            eventText.resignFirstResponder()
        }
    }
    //日付フォーム
    @objc func picker(_ sender:UIDatePicker){
        
        formatter.dateFormat = "yyyy/MM/dd"
        
        showDateText.text = formatter.string(from: sender.date)
        
    }
    
    @IBAction func saveEvent(_ sender: Any) {
        //アラートを出す
        finishedSavingAlert()
        print("データ書き込み開始")
        
        
        
        try! realm.write {
            //日付表示の内容とスケジュール入力の内容が書き込まれる。
            let Events = [Event(value: ["date": showDateText.text, "event": eventText.text])]
            realm.add(Events)
            //グローバル変数に日付を入れる
            publicDate = showDateText.text!
            print("showDateText.text")
            print("データ書き込み中")
        }
        
        print("データ書き込み完了")
        
    }
    //画面タップでテキストフィールドを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.eventText.isFirstResponder) {
            self.eventText.resignFirstResponder()
        }
    }
    // Realmマイグレーション
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
    //内容が保存されたというアラート
    func finishedSavingAlert(){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "内容が保存されました", message: "確認ボタンを押して下さい", preferredStyle: UIAlertController.Style.actionSheet)
        
        
        // 表示させたいタイトル2ボタンが押された時の処理をクロージャ実装する
        let cancelAction = UIAlertAction(title: "確認", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            //実際の処理
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
}
