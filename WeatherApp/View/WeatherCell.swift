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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func registerTo(tableView: UITableView?){
        let nib = UINib(nibName: "WeatherCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "weatherCell")
    }
    
    static func dequeueFrom(tableView: UITableView, indexPath: IndexPath) -> WeatherCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        return cell
    }
}
