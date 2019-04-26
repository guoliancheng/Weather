//
//  AppDelegate.swift
//  SoolyWeather
//
//  Created by SoolyChristina on 17/3/1.
//  Copyright © 2017年 SoolyChristina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: ScreenBounds)
        
        window?.rootViewController = DrawerViewController(rootViewController: MainViewController(rootViewController: HomeViewController()), menuViewController: MenuViewController())
        window?.makeKeyAndVisible()
        
        // 若第一次启动 定位获取城市 并请求数据
        if dataArray == nil {
            SWLocation.getCurrentCity(compeletion: { (city) in
                NetworkManager.weatherData(cityName: city)
            })
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        /// 存储数据数组(数据持久化)
        if let dataArray = dataArray {
            if dataArray.count != 0 {
                NSKeyedArchiver.archiveRootObject(dataArray, toFile: dataArrPath)
                print("存储数据成功！- 路径：" + dataArrPath)
            }
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        /// 若有缓存数据 则更新数据
        guard let city = dataArray?[0].city else {
            return
        }
        NetworkManager.weatherData(cityName: city)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

