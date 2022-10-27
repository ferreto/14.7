//
//  CDViewController.swift
//  14.7
//
//  Created by Admin on 25.10.2022.
//

import UIKit
import CoreData

class CDViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //наш data source
    var tasks = [Task]()
    var selectedID = ""
    var ID = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadTasksData()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }

    //отдаем данные из data source в UI
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = self.tasks[indexPath.row]
        let cell = UITableViewCell(style: .value1 , reuseIdentifier: "Cell")
        cell.textLabel?.text = task.name
        return cell
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedID = tasks[indexPath.row].id
    }

    
    @IBAction func deleteTask(_ sender: Any) {
        let id = selectedID

        if id != "" {
            var context: NSManagedObjectContext?
            
            context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
            request.predicate = NSPredicate(format: "taskId = %@", id)
            let result = try! context?.fetch(request)
            let deleteItem = result?.first
            context?.delete(deleteItem! as! NSManagedObject)
            do {
                try context?.save()
                self.loadTasksData()
                self.tableView.reloadData()
                selectedID = ""
            } catch {
                fatalError("Eror while delete task!")
            }
        }
    }
    
    //загружаем данные из CoreData в наш data source
    private func loadTasksData() {
        var tasks = [Task]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var context: NSManagedObjectContext?
 
           context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
            request.returnsObjectsAsFaults = false
            
            do {
                let results = try context?.fetch(request)
                
                if (results?.count)! > 0 {
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "taskId") as? String {
                            if let name = result.value(forKey: "taskName") as? String {
                                let task = Task()
                                task.id = id
                                task.name = name
                                tasks.append(task)
                            }
                        }

                    }
                }
                
            }
            catch {
                print("error")
            }
        self.tasks = tasks
    }
}
