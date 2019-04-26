//
//  UIButton+SoolyWeather.swift
//  SoolyWeather
//
//  Created by SoolyChristina on 2017/3/8.
//  Copyright © 2017年 SoolyChristina. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 便利构造器快速创建btn
    ///
    /// - Parameters:
    ///   - imageName: btn图标
    ///   - title: 指标名
    ///   - color: 指标字符颜色
    convenience init(imageName: String, title: String = "无数据") {
        self.init()
        
        let att = NSAttributedString(string: title, attributes: btnAttributes)
        setAttributedTitle(att, for: .normal)
        setImage(UIImage(named: imageName), for: UIControl.State.normal)
        imageView?.contentMode = .scaleAspectFit

    }
}
