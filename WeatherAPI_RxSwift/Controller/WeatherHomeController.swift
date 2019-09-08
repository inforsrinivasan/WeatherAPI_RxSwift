//
//  WeatherHomeController.swift
//  WeatherAPI_RxSwift
//
//  Created by Srinivasan on 08/09/19.
//  Copyright © 2019 Srinivasan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherHomeController:UIViewController{
    
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // binding
        city.rx.value.subscribe(onNext: {[weak self] city in
            
            if let city = city{
                if city.isEmpty{
                    self?.displayWeather(weather: nil)
                }
                else{
                    self?.fetchWeatherData(city: city)
                }
            }
            
        })
    }
    
    private func fetchWeatherData(city:String){
        let resource = Resource<WeatherResult>(url: URL.urlForWeatherAPI(city: city))
        
        let search = URLRequest.loadResource(resource: resource)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(WeatherResult.getDefaultWeather())
        
        search.map{ "\($0.main.temp) 🌞" }
        .bind(to: self.temperature.rx.text)
        
        search.map{ "\($0.main.humidity) 💧"}
        .bind(to: self.humidity.rx.text)
        
        .disposed(by: disposeBag)
        
//            .subscribe(onNext: { [weak self] weather in
//            self?.displayWeather(weather: weather.main)
//        })
        
    }
    
    private func displayWeather(weather:Weather?){
        
        if let weather = weather{
            self.temperature.text = "\(weather.temp) 🌞"
            self.humidity.text = "\(weather.humidity) 💧"
        }
        else{
            self.temperature.text = "🌞"
            self.humidity.text = "💧"
        }
    }
    
}
