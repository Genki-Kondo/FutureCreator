//
//  TimeViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/10/06.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var timePickerView: UIPickerView!
    @IBOutlet var timeLabel: UILabel!
    //
    let timeArray = ["0.5","1.0","1.5","2.0","2.5","3.0","3.5","4.0","4.5","5.0","5.5","6.0","6.5","7.0","7.5","8.0","8.5","9","9.5","10","10.5","11","11.5","12","12.5","13","13.5","14","14.5","15"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //起動時に変数を代入
        publicStudyHours = "0.5"
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
    }
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return timeArray.count
    }
    
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        publicStudyHours = timeArray[row]
        timeLabel.text = timeArray[row]
    }

    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return timeArray[row]
    }
    @IBAction func toVerifyView(_ sender: Any) {
        performSegue(withIdentifier: "toVerifyView", sender: nil)
    }
    

}
