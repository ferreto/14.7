//
//  AddTaskViewController.swift
//  14.7
//
//  Created by Admin on 23.10.2022.
//

import UIKit
import RealmSwift

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    
    var taskIndex: Int = 0
    private let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        let name = tfName.text
        if name != "" {
            let task = Task.getUserObject(name: name!)
            try! realm.write {
                self.realm.add(task)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    

}
