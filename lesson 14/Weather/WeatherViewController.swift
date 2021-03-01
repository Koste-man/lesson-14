//
//  WeatherViewController.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 01.03.2021.
//

import UIKit
import RealmSwift

class SearchResponse: Object {
    @objc dynamic var temp: Double = 0
}

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var temperature = [SearchResponse]()
    
    var calendar = Calendar.current
    let today = Date()
    let dateFormat = DateFormatter()
    var daysAmount = [0,1,2,3,4]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        temperature = realm.objects(SearchResponse.self).map({ $0 })
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        daysAmount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TemperatureTableViewCell
        if !temperature.isEmpty{
            cell.temperatureLabel.text = "\(temperature[indexPath.row].temp)"
        }
        for day in daysAmount{
            if indexPath.row == day{
                //CellDateLabel
                let midnight = calendar.startOfDay(for: today)
                dateFormat.dateFormat = "dd-MM-YYYY"
                let formattedDate = dateFormat.string(from: calendar.date(byAdding: .day, value: day, to: midnight)!)
                cell.dateLabel.text = "\(formattedDate)"
                
                //CellWeatherLabel
                let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=moskva&appid=b65da8724c62e02aa8372c570bdf339d&units=metric")!
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data{
                        do{
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                                let list = json["list"] as? [[String:Any]]
                                let main = list![8*day]["main"] as? [String:Any]
                                let temp = main?["temp"] as? Double
                                DispatchQueue.main.async{
                                    cell.temperatureLabel.text = "\(temp!) °C"
                                    let newTemp = SearchResponse()
                                    newTemp.temp = temp!
                                    self.temperature.append(newTemp)
                                    
                                    try! self.realm.write{
                                            self.realm.add(self.temperature)
                                    }
                                }
                            }
                        }catch{
                            print("json error")
                        }
                    }
                }
                task.resume()
            }
        }
        return cell
    }
    
}
