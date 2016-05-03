//
//  ViewController.swift
//  Weather-App
//
//  Created by Ryan Walsh on 5/2/16.
//  Copyright © 2016 Ryan Walsh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {
    
    let weatherService = WeatherService()

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.weatherService.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openCityAlert() {
        let alert = UIAlertController(
            title: "City",
            message: "Enter city name",
            preferredStyle: .Alert
        )
        
        let cancel = UIAlertAction(
            title: "Cancel",
            style: UIAlertActionStyle.Cancel,
            handler: nil
        )
        
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                let textField = alert.textFields?[0]
                let cityName = textField?.text!
                
                self.cityLabel.text = cityName
                self.weatherService.getWeather( cityName! )
        }
        
        alert.addAction( ok )
        
        alert.addAction( cancel )
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "City Name"
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK Weather Service Delegate
    
    func setWeather( weather: Weather ) {
        cityLabel.text = weather.cityName
        tempLabel.text = "\(weather.temp)"
        descriptionLabel.text = weather.description
    }

    // MARK Actions
    
    @IBAction func setCityTapped(sender: UIButton) {
        openCityAlert()
    }

}

