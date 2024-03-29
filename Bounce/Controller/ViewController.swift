//
//  ViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-09-30.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let coreDataManager = CoreDataManager()
    let styleManager = StyleManager()
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    var preferenceArray = [Preference]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreDataManager.loadPreference(&preferenceArray)
        
        /// FIX: find a way to only call this function when nickname has been changed
        if preferenceArray.count == 1 { // "if preference is set"
            nameLabel.text = preferenceArray[0].nickname
        }
        
        let iconBack = UIImage(named: "iconBack")
        navigationController?.navigationBar.backIndicatorImage = iconBack
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = iconBack
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// uncomment for path to Bounce.sqlite
        print("--- \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
        
        coreDataManager.loadPreference(&preferenceArray)
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if preferenceArray.count == 1 {
            switch hour {
            case 0 ... 11:
                greetingLabel.text = "Good Morning,"
            case 12 ... 17:
                greetingLabel.text = "Good Afternoon,"
            case 18 ... 23:
                greetingLabel.text = "Good Evening,"
            default:
                greetingLabel.text = "Hello,"
            }
            nameLabel.text = preferenceArray[0].nickname
        } else {
            greetingLabel.text = "Welcome to Bounce,"
            nameLabel.text = "👋🏼"
            placeLabel.text = "Go get set up!"
        }
        
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    
        styleManager.styleRoundButton(blueButton, "Schedule")
        styleManager.styleRoundButton(greenButton, "Add")
        styleManager.styleRoundButton(orangeButton, "Set")
        styleManager.styleRoundButton(redButton, "Library")
        
    }
    
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherModel) {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        var condition = weather.condition
        
        if preferenceArray.count == 1 {
            DispatchQueue.main.async {
                if (0 ... 5).contains(hour) || (18 ... 23).contains(hour) {
                    condition = "🌙"
                }
                self.placeLabel.text = "\(weather.cityName) \(condition) \(weather.temperatureString)°C"
            }
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
        
    }
    
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
