//
//  ViewController.swift
//  WeatherAPI
//
//  Created by Taimoor Saeed on 17/04/2017.
//  Copyright © 2017 Nano Degree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtfeild: UITextField!
    @IBOutlet weak var CityNameLbl: UILabel!
    @IBOutlet weak var CityTempLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getWeatherData(urlString: "http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=7d93fa1fca5b9d823a05232e06a6df72")
    }
    
    
    @IBAction func getDataBtn(_ sender: AnyObject) {
//        getWeatherData(urlString: "http://api.openweathermap.org/data/2.5/weather?q=Karachi&appid=7d93fa1fca5b9d823a05232e06a6df72")
        print(getWeatherData)
       
        getWeatherData(urlString: "http://api.openweathermap.org/data/2.5/weather?q=\(txtfeild.text!)&appid=7d93fa1fca5b9d823a05232e06a6df72")
        
    }
    
    func getWeatherData(urlString:String){
       
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.sync(execute: {
         self.setLables(weatherData: data!)
            })
        }
        task.resume()
    }
    
    func setLables(weatherData:Data){
        do {
            let json = try JSONSerialization.jsonObject(with: weatherData, options: .allowFragments) as! Dictionary<String, AnyObject>
            print(json)
            
            if let name = json["name"] as? String {
                CityNameLbl.text = name
            }
            if let main = json["main"] as? NSDictionary {
                if let temp = main["temp"] as? Double {
                    CityTempLbl.text = String(temp)
                }
            }
        }
        catch {
            print("error")
            return
        }
       
        
                
            }
    }

