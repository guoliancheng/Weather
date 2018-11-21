//
//  ViewController.swift
//  Weather
//
//  Created by 郭连城 on 2018/11/21.
//  Copyright © 2018 郭连城. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkTools.shared.request(type: urlType.getCityWeather(city: "北京")) { (result, isSuccess) in
            print(result)
        }
    }


}

