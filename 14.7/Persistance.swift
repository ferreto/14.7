//
//  Persistance.swift
//  14.7
//
//  Created by Admin on 19.10.2022.
//

import Foundation

class Persistance{
    static let shared = Persistance()
    
    private let kNameKey = "Persistance.kNameKey"
    private let kFioKey = "Persistance.kFio"
    
    var name: String{
        set { UserDefaults.standard.set(newValue, forKey: kNameKey) }
        get { return UserDefaults.standard.string(forKey: kNameKey) ?? "" }
    }
    
    var fio: String{
        set { UserDefaults.standard.set(newValue, forKey: kFioKey) }
        get { return UserDefaults.standard.string(forKey: kFioKey) ?? "" }
    }
    
    private let kSummarySwap = "Persistance.summarySwap"
    private let kFeelsLike = "Persistance.feelsLike"
    private let kLowTemp = "Persistance.lowTemp"
    private let kHighTemp = "Persistance.highTemp"

    var summarySwap: String{
        set { UserDefaults.standard.set(newValue, forKey: kSummarySwap) }
        get { return UserDefaults.standard.string(forKey: kSummarySwap) ?? "" }
    }
    
    var feelsLike: String{
        set { UserDefaults.standard.set(newValue, forKey: kFeelsLike) }
        get { return UserDefaults.standard.string(forKey: kFeelsLike) ?? "" }
    }

    var lowTemp: String{
        set { UserDefaults.standard.set(newValue, forKey: kLowTemp) }
        get { return UserDefaults.standard.string(forKey: kLowTemp) ?? "" }
    }
    
    var highTemp: String{
        set { UserDefaults.standard.set(newValue, forKey: kHighTemp) }
        get { return UserDefaults.standard.string(forKey: kHighTemp) ?? "" }
    }
    
}
