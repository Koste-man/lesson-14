//
//  CoreDataViewController.swift
//  lesson 14
//
//  Created by Konstantin Moskvichev on 26.02.2021.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tasks = [CoreDataListItem]()

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
                    self.saveTask(withName: text)
                    self.tableView.reloadData()
                }
            }
        }))
        present(alert, animated: true)
    }
    
    func saveTask(withName name: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CoreDataListItem", in: context) else {return}
        let taskObject = CoreDataListItem(entity: entity, insertInto: context)
        taskObject.name = name
        do{
            try context.save()
            tasks.append(taskObject)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<CoreDataListItem> = CoreDataListItem.fetchRequest()
        do{
            tasks = try context.fetch(fetchRequest)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreCell", for: indexPath) as! CoreDataTableViewCell
        cell.toDoLabel.text = tasks[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<CoreDataListItem> = CoreDataListItem.fetchRequest()
            if let task = try? context.fetch(fetchRequest){
                context.delete(task[indexPath.row])
                tasks.remove(at: indexPath.row)
                try? context.save()
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
