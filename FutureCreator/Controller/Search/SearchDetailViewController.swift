//
//  SearchDetailViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/24.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import WebKit
class SearchDetailViewController: UIViewController,WKUIDelegate {
    
    //webViewのインスタンス化
    var webView: WKWebView!
    var topPadding:CGFloat = 0
    //jsonで取得してきたURLを受け取る変数
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        
    }
    //画面が現れてからの処理
    override func viewDidAppear(_ animated: Bool){
        
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = window!.safeAreaInsets.top
        }
        
        let rect = CGRect(x: 0,
                          y: topPadding,
                          width: screenWidth,
                          height: screenHeight - topPadding)
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: rect, configuration: webConfiguration)
        
        let webUrl = URL(string: url)!
        let myRequest = URLRequest(url: webUrl)
        webView.load(myRequest)
        
        self.view.addSubview(webView)
    }
    
    
    
}
