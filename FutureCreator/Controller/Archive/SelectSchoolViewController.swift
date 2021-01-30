//
//  SchoolViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/20.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import EMTNeumorphicView
import RealmSwift

class SelectSchoolViewController: UIViewController {
    
    //FloatButtonクラスをインスタンス化
    var floatButton = FloatButton()
    //学校名のボタンの宣言
    @IBOutlet var schooButton1: EMTNeumorphicView!
    @IBOutlet var schooButton2: EMTNeumorphicView!
    @IBOutlet var schooButton3: EMTNeumorphicView!
    @IBOutlet var schooButton4: EMTNeumorphicView!
    @IBOutlet var schooButton5: EMTNeumorphicView!
    @IBOutlet var schooButton6: EMTNeumorphicView!
    @IBOutlet var anotherButton7: EMTNeumorphicView!
    
    //その他ボタン
    @IBOutlet var anotherTextField: UITextField!
    
    var buttonArray :[EMTNeumorphicView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        realmMigration()
        buttonArray = [schooButton1,schooButton2,schooButton3,schooButton4,schooButton5,schooButton6,anotherButton7]
        //ボタンを浮かせる
        floatingButton()
        
        
    }
    //ボタンを浮かせるメソッド
    func floatingButton(){
        for i in 0..<buttonArray.count{
            floatButton.changeButton(button: buttonArray[i])
        }


    }
    
    func realmAddData(){
        do {
            //インスタンスの取得
            let realm = try Realm()
            let dictionary: [String: Any] =
                ["date": publicNowDate,
                 "study": [["studyType": "算数"],
                             ["studyMethod": "英語"],
                             ["studyLaunguage": "社会"],
                             ["studyHours": "社会"]]
                ]

            let event = Event(value: dictionary)

            //書き込み処理
            try! realm.write {
                realm.add(event)
                print(event)
            }
        }
        catch {
            print(error)
        }
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
    //次のviewに画面遷移
    func nextView(){
        performSegue(withIdentifier: "toSelectAttribute", sender: nil)
    }
    @IBAction func selectTechcamp(_ sender: Any) {
        publicStudyType = "TECH::CAMP"
       nextView()
    }
    @IBAction func selectTechExpert(_ sender: Any) {
        publicStudyType = "TECH::EXPERT"
        nextView()
        
    }
    @IBAction func selectSamurai(_ sender: Any) {
        publicStudyType = "侍エンジニア塾"
        nextView()
    }
    @IBAction func selectDmmCamp(_ sender: Any) {
        publicStudyType = "DMM WEBCAMP"
        nextView()
    }
    @IBAction func selectPotepan(_ sender: Any) {
        publicStudyType = "ポテパンキャンプ"
        nextView()
    }
    @IBAction func selectKen(_ sender: Any) {
        publicStudyType = "KENスクール"
        nextView()
    }
    @IBAction func finishAnotherSchool(_ sender: Any) {
        
        publicStudyType = anotherTextField.text!
        nextView()
    }

}
