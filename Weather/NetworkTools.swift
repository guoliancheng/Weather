//
//  NetworkTools.swift
//  Weather
//
//  Created by 郭连城 on 2018/11/21.
//  Copyright © 2018 郭连城. All rights reserved.
//
import Alamofire
import Foundation
enum urlType {
//    typealias RawValue = <#type#>
    case getCityWeather(city:String)
    
    func getUrl()->String{
        switch self {
        case .getCityWeather(let city):
            if let urlCode = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                return "?format=2&cityname=\(urlCode)&key=\(AppKey)"
            }else{
                return "?format=2&cityname=\(city)&key=\(AppKey)"
            }
        }
    }
}



class NetworkTools {
    //v3都用这个 block 返回
    let baseURL = "http://v.juhe.cn/weather/index"
    
    typealias requestCallBack = (_ result: [String:Any]?, _ isSuccess: Bool)->()
    
    static let shared = NetworkTools()
    
    let manager:SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 60
        return SessionManager(configuration: configuration)
    }()
    
    
    func request(type:urlType ,parameters: [String: Any] = [:],callBack:@escaping requestCallBack){
        self.requestV20(method: .get, URLString: type.getUrl(), parameters: parameters, finished: callBack)
        
//        Alamofire.request(baseURL+type.getUrl()).responseJSON { (response) in
//            print(response)
//        }
        
    }
    
    private func requestV20(method: HTTPMethod, URLString: String,  parameters: [String: Any], finished: @escaping requestCallBack) {
        
        // 显示网络指示菊花
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        manager.request(baseURL+URLString, method: method, parameters: nil, encoding: JSONEncoding.default,headers: nil)
            .responseJSON{ (response) in
                self.netWorkResponse(response, finished: finished)
        }
    }
    
    func netWorkResponse(_ response:DataResponse<Any>,finished:requestCallBack){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //print("-----response.result.value:\(response.result.value) ")
        // 判断是否失败
        if response.result.isFailure {
            // 错误 输出！
            print("----本次网络请求失败 \(String(describing: response.result.error))")
            finished(nil,false)
//            finished(nil, NSError(domain: "joopic_string_cambuddy_network_not_available".localized(), code: -1009, userInfo: nil))
            return
        }
        let result = response.result.value! as! [String:AnyObject]
        
        let retCode = result["error_code"] as? Int
        guard (retCode == 0) else {
            print("服务器数据错误\(response.result.value!)")
            // 完成回调
            finished(nil, false)
//            LCProgressHUD.showMsg("".localized())
            return
        }
        // 完成回调
        finished(response.value as? [String : Any], true)
    }
    

}
