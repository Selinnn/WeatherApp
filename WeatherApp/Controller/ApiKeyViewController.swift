//
//  ApiKeyViewController.swift
//  WeatherApp
//
//  Created by Selin KAPLAN on 23.04.2021.
//

import UIKit
import MapKit
import CoreLocation

class ApiKeyViewController: UIViewController , CLLocationManagerDelegate {
    
    @IBOutlet weak var apiTextField: UITextField! {
        didSet {
            apiTextField.layer.borderWidth = 1
            apiTextField.layer.borderColor = UIColor(rgb: 0x8492A6).cgColor
            apiTextField.attributedPlaceholder = NSAttributedString(string: "API Key", attributes: [NSAttributedString.Key.foregroundColor:UIColor(rgb: 0x47525E)])
        }
    }
    
    let locationManager = CLLocationManager()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var locationAllowed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        navigationController?.navigationBar.isHidden = true
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        latitude = locValue.latitude
        longitude = locValue.longitude
        switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
               locationAllowed = false
            case .authorizedAlways, .authorizedWhenInUse:
                locationAllowed = true
            @unknown default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
        apiTextField.text = ""
    }
    
    @IBAction func enterBtnClick(_ sender: Any) {
        let trimmedString = apiTextField.text?.trimmingCharacters(in: .whitespaces)
        if let text = trimmedString, !text.isEmpty && locationAllowed {
          if let vc = self.storyboard?.instantiateViewController(identifier: "WeatherViewContoller") as? WeatherViewController {
            vc.apiKey = text
            vc.latitude = self.latitude
            vc.longitude = self.longitude
            navigationController?.pushViewController(vc, animated: true)
            }
            
        }else {
            let alert = UIAlertController(title: "Error", message: "Invalid API Key or not allowed location.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
