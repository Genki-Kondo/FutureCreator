//
//  ArchiveViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/17.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import EMTNeumorphicView
import RealmSwift
import Firebase
import FirebaseFirestore
// デフォルトのデータベース

let realm = try! Realm()

//日付データ保持のためのグローバル変数
var publicLikedTitleKeyArray = [String]()
var publicLikedUrlKeyArray = [String]()

var publicLikedTitleArray = [String]()
var publicLikedUrlArray = [String]()
var publicDate:String = ""
var publicNowDate:String = ""
var publicStudyType:String = ""
var publicStudyHours:String = ""
var publicStudyLaunguage:String = ""
var publicStudyMethod:String = ""

class ArchiveViewController: UIViewController {

    
    @IBOutlet var randomWordTextField: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var startButton: EMTNeumorphicView!
    @IBOutlet var dateButton: EMTNeumorphicView!
    @IBOutlet var menuButton: EMTNeumorphicView!
    
    var floatButton = FloatButton()
    
    //ログインを判断するためのフラグ
    var loginFrag = false
    //タップ数を判定
    var tapCount = 0
    //fireStoreのデータベース
    let db = Firestore.firestore()
    //今日の格言を格納する配列
    var todaysWordArray = ["壁というのは、できる人にしかやってこない。超えられる可能性がある人にしかやってこない。だから、壁がある時はチャンスだと思っている。　Byイチロー","神様は私たちに成功してほしいなんて思っていません。ただ、挑戦することを望んでいるだけよ。 Byマザー・テレサ","万策尽きたと思うな。自ら断崖絶壁の淵にたて。その時はじめて新たなる風は必ず吹く。 By松下幸之助","人を信じよ、しかし、その百倍も自らを信じよ。　By手塚治虫","どんなに勉強し、勤勉であっても、上手くいかないこともある。これは機がまだ熟していないからであるから、ますます自らを鼓舞して耐えなければならない。 By渋沢栄一","決して屈するな。決して、決して、決して！　Byウィンストン・チャーチル","成果が出ないときこそ、不安がらずに、恐れずに、迷わずに一歩一歩進めるかどうかが、成長の分岐点であると考えています。 By羽生善治","Stay hungry. Stay foolish.ハングリーであれ。愚か者であれ。 Byスティーブ・ジョブズ","何かを捨てないと前に進めない。 Byスティーブ・ジョブズ","目標を達成するには、全力で取り組む以外に方法はない。そこに近道はない。 Byマイケル・ジョーダン","10本連続でシュートを外しても僕はためらわない。次の1本が成功すれば、それは100本連続で成功する最初の1本目かもしれないだろう。 byマイケル・ジョーダン","何かを始めるのは怖いことではない。怖いのは何も始めないことだ。 byマイケル・ジョーダン","崖っぷちありがとう！最高だ！ by松岡修造","もっと熱くなれよ！熱い血燃やしてけよ！！人間熱くなったときがホントの自分に出会えるんだ！！by松岡修造","「念ずれば花開く」という言葉があります。私は何かをするとき、必ずこれは成功するという、いいイメージを思い描くようにしています。by瀬戸内寂聴","あなたが転んでしまったことに関心はない。そこから立ち上がることに関心があるのだ。 byエイブラハム・リンカーン","世界には、きみ以外には誰も歩むことのできない唯一の道がある。その道はどこに行き着くのか、と問うてはならない。ひたすら進め。byニーチェ","あなたが出会う最悪の敵は、いつもあなた自身であるだろう。byニーチェ","君が独りの時、本当に独りの時、誰もができなかったことをなしとげるんだ。だから、しっかりしろ。byジョン・レノン","すべてを今すぐに知ろうとは無理なこと。雪が解ければ見えてくる。byゲーテ"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var userNameAlartCheck:String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
        print(userNameAlartCheck)
        if userNameAlartCheck?.isEmpty == false{
            //データベースをインスタンス化
            createDataBase()
            print(userNameAlartCheck)
        }else{
            pleaseRegisterAlart()
        }

        //起動時にdatePickerを隠す
        datePicker.isHidden = true
        // 1から4の範囲で整数（Int型）乱数を生成
        let randomInt = Int.random(in: 0..<20)
        randomWordTextField.text = todaysWordArray[randomInt]
        
         //現在の日本時間を取得しグローバル変数の日付に代入する
        let f = DateFormatter()
        f.timeStyle = .none
        f.dateStyle = .medium
        f.locale = Locale(identifier: "ja_JP")
        let now = Date()
        publicNowDate = f.string(from: now)
        print(publicNowDate)
        //ボタンを立体にする
        floatButton.changeButton(button: dateButton)
        floatButton.changeButton(button: startButton)
        floatButton.changeButton(button: menuButton)
        
    }
    
    //データベースをインスタンス化
    func createDataBase(){
        
        var userNameDataCheck:String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
        db.collection("users").document(userNameDataCheck!).updateData(["データベースの有無":""]) { [self] err in
            if let err = err {
                print("Error writing document: \(err)")
                self.db.collection("users").document(userNameDataCheck!).setData(["likedTitleArray":""])
                
                let postTitleArray : [String] = [""]
                let postUrlArray : [String] = [""]
                // 要素の追加
                self.db.collection("users").document(userNameDataCheck!).updateData([
                    userNameDataCheck!+"likedTitleArray":FieldValue.arrayUnion(postTitleArray),
                    userNameDataCheck!+"likedUrlArray":FieldValue.arrayUnion(postUrlArray)
                ])
                // 要素の削除
                db.collection("users").document(userNameDataCheck!).updateData([
                    userNameDataCheck!+"likedTitleArray":FieldValue.arrayRemove([postTitleArray[0]]),
                    userNameDataCheck!+"likedUrlArray":FieldValue.arrayRemove([postUrlArray[0]])
                ])
            } else {
                
                print("Document successfully written!")
            }
        }
        
    }
    //画面遷移する時に日付を記録
    @IBAction func toMethodView(_ sender: Any) {
        //"yyyy/MM/dd/"に変換してpublicDateに代入する
        let datef = DateFormatter()
        datef.timeStyle = .none
        datef.dateStyle = .medium
        datef.locale = Locale(identifier: "ja_JP")
        publicDate = datef.string(from: datePicker.date)
        print(publicDate)
        performSegue(withIdentifier: "toMethodView", sender: nil)
        
        
    }
    //日付を変更する
    @IBAction func dateChange(_ sender: Any) {
        tapCount += 1
        //クリックの回数が偶数ならボタンが消える
        if tapCount % 2 == 0{
            randomWordTextField.isHidden = false
            datePicker.isHidden = true
        }else{
            randomWordTextField.isHidden = true
            datePicker.isHidden = false
        }
        
    }
    //先に登録のアラート
    func pleaseRegisterAlart(){
        let alert: UIAlertController = UIAlertController(title: "最初に新規登録をしてください。", message: "（新規登録しログインすると全ての機能が使えるようになります）下の新規登録ボタンをクリックしましょう！！", preferredStyle:  UIAlertController.Style.alert)


            // 新規登録ボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "新規登録", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "toMailRegister1", sender: nil)
            })
            // ゲスト
        let cancelAction: UIAlertAction = UIAlertAction(title: "ゲストとして始める", style: UIAlertAction.Style.default, handler:{ [self]
            
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
            let randomInt1 = Int.random(in: 0..<9)
            let randomInt2 = Int.random(in: 0..<9)
            let randomInt3 = Int.random(in: 0..<9)
            let randomInt4 = Int.random(in: 0..<9)
            let userName = "ゲストユーザー"+String(randomInt1)+String(randomInt2)+String(randomInt3)+String(randomInt4)
            UserDefaults.standard.set(userName, forKey: "ユーザーネーム")
            createDataBase()
            
            print(userName)
//            self.performSegue(withIdentifier: "toNameRegister", sender: nil)
//                print("ニックネームのみ")
            })

            // ③ UIAlertControllerにActionを追加
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)

            // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    
//    @IBAction func e(_ sender: Any) {
//        var userNameef:String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
//        print(userNameef!)
//    }
    
    //    @IBAction func w(_ sender: Any) {
//        let appDomain = Bundle.main.bundleIdentifier
//        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
//    }
}
//Realmの処理
protocol RealmUsable {
  static var filePath: String { get }
  static var config: Realm.Configuration { get }
  static var schema: Realm.Configuration { get }
  static func createRealm() -> Realm?
  static func addFileURL(config: Realm.Configuration) -> Realm.Configuration
}

extension RealmUsable {
    static var config: Realm.Configuration {
        var c = schema
        c.fileURL = c.fileURL?
            .deletingLastPathComponent()
            .appendingPathComponent(filePath)
            .appendingPathExtension("realm")
        return c
    }

    static var schema: Realm.Configuration {
        return Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemeVersion in
            if oldSchemeVersion < 1 {
            }
        })
    }

    static func createRealm() -> Realm? {
        do {
            return try Realm(configuration: config)
        } catch let error as NSError {
            assertionFailure("realm error: \(error)")
            var config = self.config
            config.deleteRealmIfMigrationNeeded = true
            return try? Realm(configuration: config)
        }
    }

}
