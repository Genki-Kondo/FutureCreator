//
//  SelectAttributeViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/10/11.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit

class SelectAttributeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //画面遷移
    @IBAction func toSelectLaunguage(_ sender: Any) {
        performSegue(withIdentifier: "toSelectLaunguage", sender: nil)
    }
    //画面遷移
    @IBAction func toSelectAdobe(_ sender: Any) {
        performSegue(withIdentifier: "toSelectAdobe", sender: nil)
    }
}
