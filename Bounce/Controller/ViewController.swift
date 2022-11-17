//
//  ViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-09-30.
//

import UIKit
import CoreData
import CoreLocation

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    
    var preferenceArray = [Preference]()
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("--- \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
        // uncomment above for path to Bounce.sqlite
        
        loadPreference()
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if preferenceArray.count == 1 { // "if preference is set"
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
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 26.0)]
    
        blueButton.setAttributedTitle(NSAttributedString(string: "Schedule", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        blueButton.layer.shadowOpacity = 0.1
        blueButton.layer.shadowRadius = 3.0
        blueButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        greenButton.setAttributedTitle(NSAttributedString(string: "Add", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        greenButton.layer.shadowOpacity = 0.1
        greenButton.layer.shadowRadius = 3.0
        greenButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        orangeButton.setAttributedTitle(NSAttributedString(string: "Set", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        orangeButton.layer.shadowOpacity = 0.1
        orangeButton.layer.shadowRadius = 3.0
        orangeButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        redButton.setAttributedTitle(NSAttributedString(string: "Library", attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        redButton.layer.shadowOpacity = 0.1
        redButton.layer.shadowRadius = 3.0
        redButton.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    func loadPreference() {
        let request : NSFetchRequest<Preference> = Preference.fetchRequest()
        do {
            preferenceArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
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
                if (18 ... 23).contains(hour) {
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
