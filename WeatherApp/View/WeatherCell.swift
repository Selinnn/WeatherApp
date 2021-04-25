//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Selin KAPLAN on 23.04.2021.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    var weatherViewModel : WeatherViewModel! {
        didSet {
            daysLabel.text = getDays(date: weatherViewModel.day)
            downloadImage(from: weatherViewModel.img, completion: {(img) in
                self.weatherImg.image = img
            })
            minLabel.text = weatherViewModel.min
            maxLabel.text = weatherViewModel.max
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func registerTo(tableView: UITableView?){
        let nib = UINib(nibName: "WeatherCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "weatherCell")
    }
    
    static func dequeueFrom(tableView: UITableView, indexPath: IndexPath) -> WeatherCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        return cell
    }
    
    func getDays(date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
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
    
}
