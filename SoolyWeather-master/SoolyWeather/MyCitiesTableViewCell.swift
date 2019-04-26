//
//  MyCitiesTableViewCell.swift
//  SoolyWeather
//
//  Created by SoolyChristina on 2017/3/21.
//  Copyright © 2017年 SoolyChristina. All rights reserved.
//

import UIKit

class MyCitiesTableViewCell: UITableViewCell {

    /// 温度标签
    @IBOutlet weak var tempLabel: UILabel!
    /// 天气图标
    @IBOutlet weak var weatherIcon: UIImageView!
    /// 天气标签
    @IBOutlet weak var weatherLabel: UILabel!
    /// 城市标签
    @IBOutlet weak var cityLabel: UILabel!
    /// 详细温度标签
    @IBOutlet weak var detailLabel: UILabel!
    /// 数据
    var weatherData: Weather? {
        didSet {
            tempLabel.text = "\(weatherData?.temp ?? "")°"
            weatherLabel.text = weatherData?.weather ?? ""
            cityLabel.text = weatherData?.city ?? ""
            weatherIcon.image = Weather.weatherIcon(weather: weatherData?.weather ?? "", isBigPic: false)
            detailLabel.text = "\(weatherData?.templow ?? "")℃ - \(weatherData?.temphigh ?? "")℃"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView = UIImageView(image: UIImage(named: "bg"))
        self.selectedBackgroundView = UIImageView(image: UIImage(named: "bg"))
        self.backgroundColor = UIColor.clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 遍历cell的subviews 自定义左滑删除btn
        for view in subviews {
            view.backgroundColor = UIColor.clear
            if view.isKind(of: NSClassFromString("UITableViewCellDeleteConfirmationView")!) {
                for btn in view.subviews {
                    if btn is UIButton {
                        (btn as! UIButton).setBackgroundImage(UIImage(named: "bg"), for: .normal)
                        (btn as! UIButton).backgroundColor = UIColor.clear
                    }
                }
            }
        }
    }
    
}
