//
//  RealmViewController.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 19.02.2021.
//

import UIKit
import RealmSwift

class ToDoListItem: Object {
    @objc dynamic var name = ""
}

class RealmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    var items = [ToDoListItem]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "New item", message: "Enter new to do list item", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "type here"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {_ in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    let newItem = ToDoListItem()
                    newItem.name = text
                    self.items.append(newItem)
                    try! self.realm.write{
                        self.realm.add(self.items)
                    }
                    self.tableView.reloadData()
                }
            }
        }))
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = realm.objects(ToDoListItem.self).map({ $0 })
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! RealmTableViewCell
        cell.toDoLabel.text = items[indexPath.row].name
        return cell
    }
    
}
