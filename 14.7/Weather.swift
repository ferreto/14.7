//
//  Weather.swift
//  14.7
//
//  Created by Admin on 26.10.2022.
//

import Foundation
import RealmSwift


class Weather: Object {
    
    @objc dynamic var summarySwap = String()
    @objc dynamic var feelsLike = String()
    @objc dynamic var lowTemp = String()
    @objc dynamic var highTemp = String()
    
    //статический метод для быстрой инициализации
    static func getWeatherObject(summarySwap: String, feelsLike: String, lowTemp: String, highTemp: String) -> Weather {
        let weather = Weather()
        weather.summarySwap = summarySwap
        weather.feelsLike = feelsLike
        weather.lowTemp = lowTemp
        weather.highTemp = highTemp
        return weather
    }
}
