//
//  WeatherVC.swift
//  RideWithMeGood
//
//  Created by Martin Nadeau on 2017-07-17.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var feelslikesLbl: UILabel!
    @IBOutlet weak var flLbl: UILabel!
    @IBOutlet weak var flcLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var wdLbl: UILabel!
    @IBOutlet weak var wdkLbl: UILabel!
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    var wind: Double!
    var feelslike: Int!
    var degree: Int!
    var condition: String!
    var imgURL: String!
    var city: String!
    
    var exists: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let urlRequest = URLRequest(url: URL(string: "http://api.apixu.com/v1/forecast.json?key=9a83769b9cc643ffacf10116171907&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
                    if let current = json["current"] as? [String : AnyObject] {
                        
                        if let temp = current["temp_c"] as? Int {
                            self.degree = temp
                        }
                        if let condition = current["condition"] as? [String : AnyObject] {
                            self.condition = condition["text"] as! String
                            let icon = condition["icon"] as! String
                            self.imgURL = "http:\(icon)"
                        }
                        if let feels = current["feelslike_c"] as? Int {
                            self.feelslike = feels
                        }
                        if let windspeed = current["wind_kph"] as? Double {
                            self.wind = windspeed
                        }
                    }
                    if let location = json["location"] as? [String : AnyObject] {
                        self.city = location["name"] as! String
                    }
                    
                    if let _ = json["error"] {
                        self.exists = false
                    }
                    
                    DispatchQueue.main.async {
                        if self.exists{
                            self.degreeLbl.isHidden = false
                            self.feelslikesLbl.isHidden = false
                            self.flLbl.isHidden = false
                            self.flcLbl.isHidden = false
                            self.conditionLbl.isHidden = false
                            self.windLbl.isHidden = false
                            self.wdLbl.isHidden = false
                            self.wdkLbl.isHidden = false
                            self.imgView.isHidden = false
                            
                            self.degreeLbl.text = "\(self.degree.description)°"
                            self.flLbl.text = "\(self.feelslike.description)"
                            self.wdLbl.text = "\(self.wind.description)"
                            self.cityLbl.text = self.city
                            self.conditionLbl.text = self.condition
                            self.imgView.downloadImage(from: self.imgURL!)
                        }else {
                            
                            self.degreeLbl.isHidden = true
                            self.feelslikesLbl.isHidden = true
                            self.flLbl.isHidden = true
                            self.flcLbl.isHidden = true
                            self.conditionLbl.isHidden = true
                            self.windLbl.isHidden = true
                            self.wdLbl.isHidden = true
                            self.wdkLbl.isHidden = true
                            self.imgView.isHidden = true
                            self.cityLbl.text = "No matching city found"
                            self.exists = true
                        }
                    }
                    
                    
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
}


extension UIImageView {
    
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }
        task.resume()
    }
    
}

