//
//  WeatherModel.swift
//  SoolyWeather
//
//  Created by SoolyChristina on 17/3/1.
//  Copyright © 2017年 SoolyChristina. All rights reserved.
//  天气模型

import Foundation
import HandyJSON

/// 天气数据模型
class Weather: NSObject,HandyJSON,NSCoding {
    /// 城市
    var city: String?
    /// 日期
    var date: String?
    /// 星期
    var week: String?
    /// 天气
    var weather: String?
    /// 温度
    var temp: String?
    var temphigh: String?
    var templow: String?
    /// 湿度
    var humidity: String?
    /// 气压
    var pressure: String?
    /// 风速
    var windspeed: String?
    /// 风向
    var winddirect: String?
    /// 风力
    var windpower: String?
    /// 更新时间
    var updatetime: String?
    /// 指数
    var aqi: Aqi?
    /// 生活指数
    var index: [Any]?
    /// 未来天气预报
    var daily: [Forecast]?
    
    required override init() {}
    
    // MARK: 归档
    func encode(with aCoder: NSCoder) {
        // MARK: 利用反射获取类的所有属性
        let mirror = Mirror(reflecting: self)
        
        for (label, value) in mirror.children {
            if let label = label {
                aCoder.encode(value, forKey: label)
            }
        }
    }
    
    // MARK: 解档
    required init(coder aDecoder:NSCoder) {
        super.init()
        
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            guard let label = child.label,
                let value = aDecoder.decodeObject(forKey: label) else {
                return
            }
            setValue(value, forKey: label)
        }
    }
    
    /// 根据天气类型返回天气图标
    ///
    /// - Parameters:
    ///   - weather: 天气类型
    ///   - isBigPic: 是否是大图（若为ture则 返回大图）
    /// - Returns: 返回天气图标
    class func weatherIcon(weather: String, isBigPic: Bool) -> UIImage {
        
        var x = "s"
        if isBigPic {
            x = "b"
        }
        
        switch weather {
        case "晴":
            return UIImage(named: "sun_\(x)")!
        case "多云":
            return UIImage(named: "cloudy_\(x)")!
        case "阴":
            return UIImage(named: "yin_\(x)")!
        case "雾":
            return UIImage(named: "fog_\(x)")!
        case "小雨":
            return UIImage(named: "rain_\(x)_s")!
        case "中雨":
            return UIImage(named: "rain_\(x)_m")!
        case "大雨":
            return UIImage(named: "rain_\(x)_h")!
        case "暴雨":
            return UIImage(named: "rain_\(x)_hh")!
        case "小雪":
            return UIImage(named: "snow_\(x)_s")!
        case "中雪":
            return UIImage(named: "snow_\(x)_m")!
        case "大雪":
            return UIImage(named: "snow_\(x)_h")!
        case "暴雪":
            return UIImage(named: "sonw_\(x)_h")!
        case "阵雨":
            return UIImage(named: "zhenyu_\(x)")!
        case "雷阵雨":
            return UIImage(named: "leizhenyu_\(x)")!
        default:
            return UIImage(named: "cloudy_\(x)")!
        }
    }
    
    func pm2_5Icon(index: String) -> UIImage {
        
        switch index {
        case "优":
            return UIImage(named: "nice")!
        case "良":
            return UIImage(named: "ok")!
        case "无数据":
            return UIImage(named: "nice")!
        default:
            return UIImage(named: "bad")!
        }
    }
    
}

class Aqi: NSObject,HandyJSON,NSCoding {
    /// pm2.5
    var ipm2_5: String?
    /// 空气质量
    var quality: String?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ipm2_5, forKey: "ipm2_5")
        aCoder.encode(quality, forKey: "quality")
    }
    
    required init(coder aDecoder:NSCoder) {
        ipm2_5 = aDecoder.decodeObject(forKey: "ipm2_5") as? String
        quality = aDecoder.decodeObject(forKey: "quality") as? String
    }
    
    required override init() {}
}

/// 未来天气预报
class Forecast: NSObject,HandyJSON,NSCoding {
    var date: String?
    var week: String?
    var sunrise: String?
    var sunset: String?
    var day: Day?
    var night: Night?
    
    func encode(with aCoder: NSCoder) {
        let mirror = Mirror(reflecting: self)
        for (label, value) in mirror.children {
            aCoder.encode(value, forKey: label ?? "")
        }
    }
    
    required init(coder aDecoder:NSCoder) {
        super.init()
        
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            guard let label = child.label,
                let value = aDecoder.decodeObject(forKey: label) else {
                    return
            }
            setValue(value, forKey: label)
        }
        
    }
    
    required override init() {}
}

/// 白天
class Day: NSObject,HandyJSON,NSCoding {
    var temphigh: String?
    var weather: String?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(temphigh, forKey: "Dtemphigh")
        aCoder.encode(weather, forKey: "Dweather")
    }
    
    required init(coder aDecoder:NSCoder) {
        temphigh = aDecoder.decodeObject(forKey: "Dtemphigh") as? String
        weather = aDecoder.decodeObject(forKey: "Dweather") as? String
    }
    
    required override init() {}
}

/// 夜间
class Night: NSObject,HandyJSON,NSCoding {
    var templow: String?
    var weather: String?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(templow, forKey: "Ntemplow")
        aCoder.encode(weather, forKey: "Nweather")
    }
    
    required init(coder aDecoder:NSCoder) {
        templow = aDecoder.decodeObject(forKey: "Ntemplow") as? String
        weather = aDecoder.decodeObject(forKey: "Nweather") as? String
    }
    
    required override init() {}
}

