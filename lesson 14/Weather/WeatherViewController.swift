//
//  WeatherViewController.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 01.03.2021.
// 123

import UIKit
import RealmSwift

class SearchResponse: Object {
    @objc dynamic var temp: Double = 0
}

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var temperature = [SearchResponse](){
        didSet{
            try! realm.write{
                realm.add(temperature)
            }
        }
    }
    
    
    var calendar = Calendar.current
    let today = Date()
    let dateFormat = DateFormatter()
    var daysAmount = [0,1,2,3,4]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        temperature = realm.objects(SearchResponse.self).map({ $0 })
        loadWeather()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        daysAmount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TemperatureTableViewCell
                //CellTemperatureLabel
        if !temperature.isEmpty{
            cell.temperatureLabel.text = "\(temperature[indexPath.row].temp)"
        }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                cell.temperatureLabel.text = "\(self.temperature[indexPath.row].temp)"
        }
                //CellDateLabel
        let midnight = calendar.startOfDay(for: today)
        dateFormat.dateFormat = "dd-MM-YYYY"
        let formattedDate = dateFormat.string(from: calendar.date(byAdding: .day, value: indexPath.row, to: midnight)!)
        cell.dateLabel.text = "\(formattedDate)"
        
        return cell
    }
    func loadWeather(){
        for day in daysAmount{
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=moskva&appid=b65da8724c62e02aa8372c570bdf339d&units=metric")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        let list = json["list"] as? [[String:Any]]
                        let main = list![8*day]["main"] as? [String:Any]
                        let temp = main?["temp"] as? Double
                        DispatchQueue.main.asyncAfter(deadline: .now()){
                            let newTemp = SearchResponse()
                            newTemp.temp = temp!
                            self.temperature.append(newTemp)
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
}
