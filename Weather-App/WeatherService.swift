//
//  WeatherService.swift
//  Weather-App
//
//  Created by Ryan Walsh on 5/2/16.
//  Copyright © 2016 Ryan Walsh. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    func setWeather( weather: Weather )
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    func getWeather( city: String ) {
        
        let cityForUrl: String? = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityForUrl!)&appid=\(Secrets.apiKey)"
        let url = NSURL( string: path )
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, err: NSError?) in
            let json = JSON(data: data!)
            let weather = Weather(cityName: json["name"].string!, temp: json["main"]["temp"].double!, description: json["weather"][0]["description"].string!)
            
            if self.delegate != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.setWeather( weather )
                })
            }
        }
        
        task.resume()
    }
    
}