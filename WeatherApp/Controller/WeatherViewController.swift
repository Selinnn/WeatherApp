//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Selin KAPLAN on 23.04.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            WeatherCell.registerTo(tableView: self.tableView)
        }
    }
    var apiKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    
}

extension WeatherViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WeatherCell.dequeueFrom(tableView: tableView, indexPath: indexPath)
        cell.daysLabel.text = "Friday"
        return cell
    }
    
    
}
