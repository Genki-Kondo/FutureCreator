//
//  Test1ViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/09/22.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import RealmSwift
class Test1ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        realmMigration()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toResult1(_ sender: Any) {
        performSegue(withIdentifier: "result", sender: nil)
        print("データ書き込み開始")

//            let realm = try! Realm()

            try! realm.write {
                //日付表示の内容とスケジュール入力の内容が書き込まれる。
                let Events = [Event(value: ["date": publicDate, "event": "独学"])]
                realm.add(Events)
                print(publicDate)
                print("データ書き込み中")
            }

        print("データ書き込み完了")

        //前のページに戻る
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func toResult2(_ sender: Any) {
        performSegue(withIdentifier: "result", sender: nil)
        print("データ書き込み開始")

//            let realm = try! Realm()

            try! realm.write {
                //日付表示の内容とスケジュール入力の内容が書き込まれる。
                let Events = [Event(value: ["date": publicDate, "event": "学校で学ぶ"])]
                realm.add(Events)
                print(publicDate)
                print("データ書き込み中")
            }

        print("データ書き込み完了")

        //前のページに戻る
        dismiss(animated: true, completion: nil)
    }
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
}
