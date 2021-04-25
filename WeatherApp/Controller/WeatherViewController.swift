//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Selin KAPLAN on 23.04.2021.
//

import UIKit

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            WeatherCell.registerTo(tableView: self.tableView)
        }
    }
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentIcon: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    var apiKey = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var weather: Weather?
    var weatherModels = [WeatherModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    
    func insertCurrent(code: String, timeZone: String, temp: Double) {
        let url = URL(string: "http://openweathermap.org/img/wn/\(code)@2x.png")
        downloadImage(from: url!, completion: {img in
            self.currentIcon.image = img
        })
        self.cityLabel.text = timeZone
        self.currentTempLabel.text = "\(String(format: "%.0f", temp - 273.15))°"
    }
    
    func createModel() {
        for i in 1..<weather!.daily.count {
            let weatherDay = weather!.daily[i]
            weatherModels.append(WeatherModel(day: weatherDay.dt, imgUrl:"http://openweathermap.org/img/wn/\(weatherDay.weather.first!.icon)@2x.png", min: weatherDay.temp.min, max: weatherDay.temp.max))
        }
        self.tableView.reloadData()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(UIImage(data: data))
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let postRequest = APIRequest(fullurl: "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely,hourly,alerts&appid=\(apiKey)")
        postRequest.post(completion: { result in
            switch result {
            case .success(let weather):
                print("success")
                self.weather = weather
                DispatchQueue.main.async {
                    self.insertCurrent(code: weather.current.weather.first!.icon, timeZone: weather.timezone, temp: weather.current.temp)
                    self.createModel()
                }
            case .failure(let error):
                print("failure \(error)")
            }
        })
    }
    
}

extension WeatherViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = weather?.daily.count {
            return count - 1
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WeatherCell.dequeueFrom(tableView: tableView, indexPath: indexPath)
        cell.weatherViewModel = WeatherViewModel(weatherModels[indexPath.row])
        return cell
    }
    
    
}
