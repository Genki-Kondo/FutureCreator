//
//  DayAndTimeViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/07/21.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit

class DayAndTimeViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    var selectedImg: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = selectedImg
        
    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "toCalender", sender: nil)
    }
    
    

}
