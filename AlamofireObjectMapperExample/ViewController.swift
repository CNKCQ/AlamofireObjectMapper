//
//  ViewController.swift
//  AlamofireObjectMapperExample
//
//  Created by KingCQ on 2017/2/21.
//  Copyright © 2017年 Tristan Himmelman. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let URL = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/2ee8f34d21e8febfdefb2b3a403f18a43818d70a/sample_keypath_json"
//        let expectation = expectationWithDescription("\(URL)")
        
        Alamofire.request(URL).responseObject(keyPath: "data") { (response: DataResponse<WeatherResponse>) in
//            expectation.fulfill()
            
            let weatherResponse = response.result.value
            print(weatherResponse!, "🌹", (response.response?.statusCode)!)
            print(weatherResponse!.location!)
            
            if let threeDayForecast = weatherResponse?.threeDayForecast {
                for forecast in threeDayForecast {
                    print(forecast.day!)
                    print(forecast.temperature!)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


class WeatherResponse: Mappable {
    var location: String?
    var threeDayForecast: [Forecast]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        location <- map["location"]
        threeDayForecast <- map["three_day_forecast"]
    }
}

class Forecast: Mappable {
    var day: String?
    var temperature: Int?
    var conditions: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        day <- map["day"]
        temperature <- map["temperature"]
        conditions <- map["conditions"]
    }
}

