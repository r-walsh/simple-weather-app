//
//  Weather.swift
//  Weather-App
//
//  Created by Ryan Walsh on 5/2/16.
//  Copyright © 2016 Ryan Walsh. All rights reserved.
//

import Foundation

struct Weather {
    let cityName: String
    let temp: Double
    let description: String
    
    init( cityName: String, temp: Double, description: String ) {
        self.cityName = cityName
        self.temp = temp
        self.description = description
    }
}