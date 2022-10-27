//
//  RViewController.swift
//  14.7
//
//  Created by Admin on 19.10.2022.
//

import UIKit
import RealmSwift

class RViewController: UIViewController, UITableViewDelegate, UITableViewDataSource/*UITableViewController*/ {
    //наш data source
    var tasks = [Task]()
    let realm = try! Realm()
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
        return CGFloat(68)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedID = tasks[indexPath.row].id
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        let id = selectedID

        if id != "" {
            let taskToDelete = realm.objects(Task.self).where {
                $0.id == id
            }.first!
            try! realm.write {
                self.realm.delete(taskToDelete)
                self.loadTasksData()
                self.tableView.reloadData()
                selectedID = ""
            }
        }
        
    }
    
    //загружаем данные из Realm в наш data source
    private func loadTasksData() {
        let realmInstance = try! Realm()
        var tasks = [Task]()
        for task in realmInstance.objects(Task.self) {
            tasks.append(task)
        }
        self.tasks = tasks
    }
}
