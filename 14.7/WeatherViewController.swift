//
//  WeatherViewController.swift
//  14.7
//
//  Created by Admin on 26.10.2022.
//

import UIKit
import Alamofire
import SwiftUI
import Foundation

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tfLatitude: UITextField!
    @IBOutlet weak var tfLongitude: UITextField!
    @IBOutlet weak var lbTemperature: UILabel!
    @IBOutlet weak var lbFeels: UILabel!
    @IBOutlet weak var lbHight: UILabel!
    @IBOutlet weak var lbLow: UILabel!
    @IBOutlet weak var btnReload: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lbTemperature.text = Persistance.shared.summarySwap
        lbFeels.text = Persistance.shared.feelsLike
        lbHight.text = Persistance.shared.highTemp
        lbLow.text = Persistance.shared.lowTemp
    }
    
    @IBAction func reload(_ sender: Any) {
        let newURL = "https://darksky.net/forecast/" + tfLatitude.text! + "," + tfLongitude.text! + "/si12/en"
        loadWeather(url: newURL)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadWeather(url: "https://darksky.net/forecast/55.1842,30.2008/si12/en")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Persistance.shared.summarySwap = lbTemperature.text!
        Persistance.shared.feelsLike = lbFeels.text!
        Persistance.shared.highTemp = lbHight.text!
        Persistance.shared.lowTemp = lbLow.text!
    }
    
    func loadWeather(url: String) {
       //  let strImageURL = "https://darksky.net/images/weather-icons/cloudy.png"
         let strURL = url
       //  let imageUrl = URL(string: strImageURL)
       //  weatherIcon.load(url: imageUrl!)
       
        AF.request(strURL).response { [self] response in
         //    debugPrint(response)
             guard
                 let data = response.data,
                 let string = String(data: data, encoding: .utf8)
                 else { return }
         //        print(string)

             if let range = string.range(of: "summary swap") {
                 let foundind = range.lowerBound
                 let start = string.index(foundind, offsetBy: 14)
                 let end = string.index(foundind, offsetBy: 17)
          //       let range2 = start..<end
                 let subst = string[start..<end]
                 let aString = String(subst)
                 let newString = aString.replacingOccurrences(of: "&", with: " ", options: .literal, range: nil)
                 self.lbTemperature.text = newString
                 Persistance.shared.summarySwap = newString
                 print(subst)
             }
             else {
          //     print("summary swap not found")
               self.lbTemperature.text = "Current temperature not found"
             }
             
             if let range = string.range(of: "feels-like-text") {
                 let foundind = range.upperBound
                 let start = string.index(foundind, offsetBy: 2)
                 let end = string.index(foundind, offsetBy: 5)
                 let subst = string[start..<end]
                 let aString = String(subst)
                 let newString = aString.replacingOccurrences(of: "<", with: " ", options: .literal, range: nil)
                 self.lbFeels.text = "Feels Like: " + newString
                 Persistance.shared.feelsLike = "Feels Like: " + newString
                 print(subst)
             }
             else {
        //       print("feels like not found")
               self.lbFeels.text = "Feels like temperature not found"
             }
             
             if let range = string.range(of: "low-temp-text") {
                 let foundind = range.upperBound
                 let start = string.index(foundind, offsetBy: 2)
                 let end = string.index(foundind, offsetBy: 5)
                 let subst = string[start..<end]
                 let aString = String(subst)
                 let newString = aString.replacingOccurrences(of: "<", with: " ", options: .literal, range: nil)
                 self.lbLow.text = "Low: " + newString
                 Persistance.shared.lowTemp = "Low: " + newString
                 print(subst)
             }
             else {
                 self.lbLow.text = "Low temperature not found"
             }
             
             if let range = string.range(of: "high-temp-text") {
                 let foundind = range.upperBound
                 let start = string.index(foundind, offsetBy: 2)
                 let end = string.index(foundind, offsetBy: 5)
                 let subst = string[start..<end]
                 let aString = String(subst)
                 let newString = aString.replacingOccurrences(of: "<", with: " ", options: .literal, range: nil)
                 self.lbHight.text = "High: " + newString
                 Persistance.shared.highTemp = "High: " + newString
                 print(subst)
             }
             else {
                 self.lbLow.text = "High temperature not found"
             }
             
             if let range = string.range(of: "currently-icon") {
                 let foundind = range.upperBound
                 let start = string.index(foundind, offsetBy: 53)
                 let end = string.index(foundind, offsetBy: 90)
                 let subst = string[start..<end]
                 let aString = String(subst)
             //    let newString = aString.replacingOccurrences(of: "<", with: " ", options: .literal, range: nil)
                 if let range2 = aString.range(of: ".png") {
                     let foundind2 = range2.upperBound
                     let start2 = aString.startIndex
                     let end2 = foundind2
                     let subst2 = aString[start2..<end2]
                     print(subst2)
                     let imageURL = "https://darksky.net" + subst2
                     let iURL = URL(string: imageURL)
                     print(imageURL)
                     weatherIcon.load(url: iURL!)
                 }
             }
             else {
                 self.lbLow.text = "High temperature not found"
             }
             
         }
         
     }
}



extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

