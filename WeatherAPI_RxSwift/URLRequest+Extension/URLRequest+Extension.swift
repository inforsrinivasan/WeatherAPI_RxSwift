//
//  URLRequest+Extension.swift
//  WeatherAPI_RxSwift
//
//  Created by Srinivasan on 08/09/19.
//  Copyright © 2019 Srinivasan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// https://api.openweathermap.org/data/2.5/weather?q=London&appid=fab018e2d8d06fafa57694c34ceda403

struct Resource<T>{
    var url:URL
}

extension URL{
    static func urlForWeatherAPI(city:String)->URL{
        return URL.init(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=fab018e2d8d06fafa57694c34ceda403")!
    }
}

extension URLRequest{
    
    static func loadResource<T:Decodable>(resource:Resource<T>)->Observable<T>{
        return Observable.just(resource.url)
            .flatMap{ url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
            }.map{ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
        }.asObservable()
        
    }
    
}
