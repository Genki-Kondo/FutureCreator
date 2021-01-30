//
//  SelectAdobeViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/10/11.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import EMTNeumorphicView
class SelectAdobeViewController: UIViewController {

    @IBOutlet var anotherButton: EMTNeumorphicView!
    @IBOutlet var anotherTextFiled: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //画面遷移する為のメソッド
    func toNextView(){
        performSegue(withIdentifier: "toTimeView", sender: nil)
    }
    @IBAction func selectAfterEffect(_ sender: Any) {
        publicStudyLaunguage = "AfterEffect"
        toNextView()
    }
    @IBAction func selectPremire(_ sender: Any) {
        publicStudyLaunguage = "PremirePro"
        toNextView()
    }
    @IBAction func selectExperience(_ sender: Any) {
        publicStudyLaunguage = "ExperienceDesign"
        toNextView()
    }
    @IBAction func selectIllustrator(_ sender: Any) {
        publicStudyLaunguage = "Illustrator"
        toNextView()
    }
    @IBAction func selectLightroom(_ sender: Any) {
        publicStudyLaunguage = "Lightroom"
        toNextView()
    }
    @IBAction func selectPhotoshop(_ sender: Any) {
        publicStudyLaunguage = "Photoshop"
        toNextView()
    }
    @IBAction func finishAnotherLanguage(_ sender: Any) {
        publicStudyLaunguage = anotherTextFiled.text!
        toNextView()
    }
}
