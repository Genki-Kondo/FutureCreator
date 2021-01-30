//
//  SearchViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/24.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Firebase
import FirebaseFirestore
class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITabBarDelegate, UITabBarControllerDelegate {
    
    
    
    @IBOutlet var searchBar: UISearchBar!
    
    //ログインを判断するためのフラグ
    var loginFrag = false
    //fireStoreのデータベース
    let db = Firestore.firestore()
    //レルムデータベースのインスタンス化
    var ref = Database.database().reference()
    //取得したデータを一度保管する為の配列
    var selectTitleArray:[String] = []
    var selectUrlArray:[String] = []
    //jsonで取得してきたURLを格納する変数
    var selectUrl: String!
    var selectTitle: String!
    var articles = [[String: AnyObject]]()
    let baseURL = "https://qiita.com/api/v2/items"
    
    //端末に保存したユーザーネームの格納する変数
    
    
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        
        
        
        //Delegateを宣言
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        //tableviewにQiitaの記事を表示する
        getArticleData(url: baseURL)
        tableview.keyboardDismissMode = .onDrag
//        loginJudge()
//        if loginFrag != false{
//            createDataBase()
//        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        loginJudge()
//        if loginFrag != false{
//            createDataBase()
//        }
        
        
    }
    //タブバーをタップ時の反応
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        pleaseLoginAlert()
//    }
    //データベースをインスタンス化
    func createDataBase(){
        
        var userNameDataCheck :String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
        db.collection("users").document(userNameDataCheck!).updateData(["データベースの有無":""]) { [self] err in
            if let err = err {
                print("Error writing document: \(err)")
                self.db.collection("users").document(userNameDataCheck!).setData(["likedTitleArray":""])
                
//                let postTitleArray = ["",""]
//                let postUrlArray = ["",""]
//                // 要素の追加
//                db.collection("users").document(userName!).updateData([
//                    userName!+"likedTitleArray":FieldValue.arrayUnion(postTitleArray),
//                    userName!+"likedUrlArray":FieldValue.arrayUnion(postUrlArray)
//                ])
            } else {
                
                print("Document successfully written!")
            }
        }
        
    }
    //Qiitaで取得した情報を表示
    func getArticleData(url: String) {
        
        AF.request(url, method: .get)
            .responseJSON { response in
                if (response.value != nil) {
                    
                    print("Success! Got the data")
                    let articles : JSON = JSON(response.value!)
                    if let article = articles.arrayObject {
                        self.articles = article as! [[String: AnyObject]]
                        print(articles)
                    }
                } else {
                    print("Error: \(String(describing: response.error))")
                }
                
                if self.articles.count > 0 {
                    self.tableview.reloadData()
                }
            }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        getArticleData(url: baseURL + "?page=1&query=tag%3A" + searchBar.text!)
        tableview.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let articlePath = articles[indexPath.row]
        cell.textLabel?.text = articlePath["title"] as? String
        //        selectTitle = articlePath["title"] as? String
        return cell
    }
    // cellがタップされた時その記事のページに移動する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newArticle = articles[indexPath.row]
        selectUrl = newArticle["url"] as! String
        performSegue(withIdentifier: "toSearchDetail", sender: nil)
    }
    //cellが左にスワイプされた時にお気に入り登録するメソッドfirestoreに書き換え
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let likedButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "お気に入り登録") { [self] (action, index) -> Void in
            var userNameFir :String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
            //ユーザーがログインしたか判定する
            loginJudge()
            
            if loginFrag == true{
                //元々のコード　firebase
                //                let articlePath = self.articles[indexPath.row]
                //
                //                var userID = Auth.auth().currentUser?.uid
                //                //データベースの作成
                //                let infoTitleDB = self.ref.child(self.userName+"Title").childByAutoId()
                //
                //                let infoUrlDB = self.ref.child(self.userName+"Url").childByAutoId()
                //                //データを追加する時のchildByAutoIdのキーを取得
                //                let infoTitleDBKey = infoTitleDB.key
                //                let infoUrlDBKey = infoUrlDB.key
                //
                //                //取得したキーを配列に入れていく
                //                publicLikedTitleKeyArray.append(infoTitleDBKey!)
                //                publicLikedUrlKeyArray.append(infoUrlDBKey!)
                //
                //                print(publicLikedTitleKeyArray)
                //                print(publicLikedUrlKeyArray)
                //                let postTitle = ["likedTitle": articlePath["title"] as! String] as [String : Any]
                //                let postUrl = ["likedUrl": articlePath["url"] as! String] as [String : Any]
                //
                //                infoTitleDB.updateChildValues(postTitle)
                //                infoUrlDB.updateChildValues(postUrl)
                //                //前回のデータをリセット
                //                publicLikedTitleArray.removeAll()
                //                publicLikedUrlArray.removeAll()
                //取得したキーを配列に入れていく
                let articlePath = self.articles[indexPath.row]
                let postTitleArray = [articlePath["title"] as! String] as [String]
                
                let postUrlArray = [articlePath["url"] as! String] as [String]
                
                
                //filterを使いお気に入りの重複を避ける
                let ansTitle = publicLikedTitleArray.filter{$0 == articlePath["title"] as! String}
                
                //重複していない場合配列に追加していく
                if ansTitle == [] {
                    print("重複してません")
                    //配列に追加していく
                    publicLikedTitleArray.append(contentsOf: postTitleArray)
                    publicLikedUrlArray.append(contentsOf: postUrlArray)
                } else {
                    print("重複してます")
                }
                // 要素の追加
                
                db.collection("users").document(userNameFir!).updateData([
                    userNameFir!+"likedTitleArray":FieldValue.arrayUnion(postTitleArray),
                    userNameFir!+"likedUrlArray":FieldValue.arrayUnion(postUrlArray)
                ])
                
                print(postTitleArray)
                print(postUrlArray)
                
                
            }
            //お気に入りに登録したことを伝えるアラート
            self.LikedAlert()
        }
        likedButton.backgroundColor = UIColor.red
        
        return [likedButton]
    }
    //ログインしてくださいというアラートのメソッド
    func pleaseLoginAlert(){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "先にログインしてください", message: "ログインしていないとお気に入り機能が使えません", preferredStyle: UIAlertController.Style.actionSheet)
        
        
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
    //お気に入りに登録したことを伝えるアラート
    func LikedAlert(){
        let alertTitle = "お気に入りに登録しました"
        let alertMessage = "登録した情報はメニュー画面で確認できます"
        let alert: UIAlertController = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle:  UIAlertController.Style.alert
        )
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        // UIAlertController に Action を追加
        alert.addAction(defaultAction)
        // Alertを表示
        present(alert, animated: true, completion: nil)
    }
    //ユーザーがログインしたか判定する為のメソッド
    func loginJudge(){
        
        
        if Auth.auth().currentUser != nil {
            //ユーザーがサインインしてる場合
            loginFrag = true
            print("ユーザーがサインインしてる")
        } else {
            loginFrag = false
            //ユーザーがサインインしてない場合
            pleaseLoginAlert()
            
            print("ユーザーがログアウトしてる")
            
        }
    }
    // 画面遷移した際
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let SearchDetailVC: SearchDetailViewController = (segue.destination as? SearchDetailViewController)!
        SearchDetailVC.url = selectUrl
    }
    //キーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
        
    }
    
    //キーボードを閉じる
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.endEditing(true)
        return true
    }
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        switch item.tag {
//        case 2:
//            pleaseLoginAlert()
//            
//        default: break
//            
//            
//        }
//    }
    //先に登録のアラート
    func pleaseRegisterAlart(){
        let alert: UIAlertController = UIAlertController(title: "最初に新規登録をしてください。", message: "（新規登録しログインすると全ての機能が使えるようになります）下の新規登録ボタンをクリックしましょう！！", preferredStyle:  UIAlertController.Style.alert)


            // 新規登録ボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "新規登録", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "toMailRegister2", sender: nil)
            })
            // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{ [self]
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

