//
//  likedViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/25.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
class likedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    
    //情報を次々に入れていくための配列や変数
    var userInfo = [UserInfo]()
    var selectUrl :String = ""
    //レルムのデータベースをインスタンス化
    var ref = Database.database().reference()
    //ログインフラグ
    var loginFrag = false
    
    //fireStoreのデータベース
    let db = Firestore.firestore()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "LikedCustumCell", bundle: nil), forCellReuseIdentifier: "LikedCustumCell")
        
        //delegateの宣言
        tableView.delegate = self
        tableView.dataSource = self
        //firebaseからデータを取ってくる
        
        
        loginJudge()
        if loginFrag == true{
            fetchContentsData2()
        }
        tableView.reloadData()
        print(publicLikedUrlArray)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if loginFrag == true{
            fetchContentsData2()
        }
        tableView.reloadData()
        
    }
    //cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return publicLikedTitleArray.count
        
    }
    //cellの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikedCustumCell", for: indexPath) as! LikedCustumCell
        cell.likedTitleLabel.text = publicLikedTitleArray[indexPath.row]
        
        
        return cell
    }
    // cellがタップされた時その記事のページに移動する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectUrl = publicLikedUrlArray[indexPath.row]
        performSegue(withIdentifier: "toLikedDetail", sender: nil)
    }
    // 画面遷移した際
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let likedDetailVC: LikedDetailViewController = (segue.destination as? LikedDetailViewController)!
        likedDetailVC.url = selectUrl
    }
    
    
    
    //cellが左にスワイプされた時にお気に入り解除するメソッド
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "お気に入り解除") { [self] (action, index) -> Void in
            //ユーザーがログインしたか判定する
            loginJudge()
            if loginFrag == true{
                
                //            var userID = Auth.auth().currentUser?.uid
                //
                //            let infoTitleDB = self.ref.child(self.userName+"Title").childByAutoId().child()
                //            let infoUrlDB = self.ref.child(self.userName+"Url").childByAutoId()
                
                //            let infoTitleDB = self.ref.child(self.userName+"Title").childByAutoId()
                //            let infoUrlDB = self.ref.child(self.userName+"Url").childByAutoId()
                //            let postTitle = ["likedTitle": publicLikedTitleArray[indexPath.row] as! String] as [String : Any]
                //
                //            infoTitleDB.updateChildValues(postTitle)
                //            infoUrlDB.updateChildValues(postUrl)
                //選択したセルを配列から削除
                //                if publicLikedUrlArray.count <= 1{
                //                    publicLikedUrlArray.remove(at: indexPath.row - 1)
                //                    publicLikedTitleArray.remove(at: indexPath.row - 1)
                //                }else{
                
                
                //                }
                
                //取得したキーを配列に入れていく
                
                let postTitleArray = [publicLikedTitleArray[indexPath.row] ] as [String]
                
                let postUrlArray = [publicLikedUrlArray[indexPath.row] ] as [String]
                //端末に保存したユーザーネームの格納する変数
                var userNameFir :String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
                // 要素の削除
                db.collection("users").document(userNameFir!).updateData([
                    userNameFir!+"likedTitleArray":FieldValue.arrayRemove([publicLikedTitleArray[indexPath.row]]),
                    userNameFir!+"likedUrlArray":FieldValue.arrayRemove([publicLikedUrlArray[indexPath.row]])
                ])
                publicLikedTitleArray.remove(at: indexPath.row)
                publicLikedUrlArray.remove(at: indexPath.row)
                tableView.reloadData()
                //削除した確認アラートを出す
                self.deleteAlert()
            }
        }
        deleteButton.backgroundColor = UIColor.green
        return [deleteButton]
        
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
    
//    func fetchContentsData (){
//        db.collection("users").getDocuments { [self] (querySnapshot, err) in
//            if let err = err {
//                print("エラー")
//            }else{
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//
//                    publicLikedTitleArray = document.data()[userName!+"likedTitleArray"] as! [String]
//                    publicLikedUrlArray = document.data()[userName!+"likedUrlArray"] as! [String]
//
//                }
//                
//            }
//        }
//
//    }
    func fetchContentsData2 (){
        //端末に保存したユーザーネームの格納する変数
        var userNameDataFetch :String? = UserDefaults.standard.object(forKey: "ユーザーネーム") as! String?
        let docRef = db.collection("users").document(userNameDataFetch!)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                publicLikedTitleArray = document.data()![userNameDataFetch!+"likedTitleArray"] as! [String]
                publicLikedUrlArray = document.data()![userNameDataFetch!+"likedUrlArray"] as! [String]
                print("Document data: \(publicLikedTitleArray)")
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    //お気に入りを解除したことを伝えるアラート
    func deleteAlert(){
        let alertTitle = "お気に入りを解除しました"
        let alertMessage = "確認したらOKをタップしてください"
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
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        switch item.tag {
//        case 2:
//            pleaseLoginAlert()
//
//        default: break
//
//
//                }
//    }
}
