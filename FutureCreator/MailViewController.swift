//
//  MailViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/12/19.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import MessageUI
class MailViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        sendMail()
    }
    //新規メールを開く
    func sendMail() {
        //メール送信が可能なら
        if MFMailComposeViewController.canSendMail() {
            //MFMailComposeVCのインスタンス
            let mail = MFMailComposeViewController()
            //MFMailComposeのデリゲート
            mail.mailComposeDelegate = self
            //送り先
            mail.setToRecipients(["business1excite@gmail.com"])
            //Cc
            mail.setCcRecipients([""])
            //Bcc
            mail.setBccRecipients([""])
            //件名
            mail.setSubject("件名")
            //メッセージ本文
            mail.setMessageBody("開発者に問い合わせ", isHTML: false)
            //メールを表示
            self.present(mail, animated: true, completion: nil)
            //メール送信が不可能なら
        } else {
            //アラートで通知
            let alert = UIAlertController(title: "No Mail Accounts", message: "Please set up mail accounts", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //エラー処理
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if error != nil {
            //送信失敗
            print(error)
        } else {
            switch result {
            case .cancelled: break
            //キャンセル
            case .saved: break
            //下書き保存
            case .sent: break
            //送信
            default:
                break
            }
            controller.dismiss(animated: true, completion: nil)
        }
    }
}
