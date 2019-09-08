//
//  Weather.swift
//  WeatherAPI_RxSwift
//
//  Created by Srinivasan on 08/09/19.
//  Copyright © 2019 Srinivasan. All rights reserved.
//

import Foundation

struct WeatherResult:Decodable{
    let main:Weather
    
    static func getDefaultWeather()->WeatherResult{
        return WeatherResult.init(main: Weather.init(temp: 0.0, humidity: 0.0))
    }
}

struct Weather:Decodable{
    let temp:Double
    let humidity:Double
}
