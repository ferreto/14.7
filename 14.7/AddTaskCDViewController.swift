//
//  AddTaskCDViewController.swift
//  14.7
//
//  Created by Admin on 26.10.2022.
//

import UIKit
import CoreData

class AddTaskCDViewController: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    
    
    var taskIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func saveTask(_ sender: Any) {
        let name = tfName.text
        if name != "" {
            let task = Task.getUserObject(name: name!)
            task.name = name!
            var context: NSManagedObjectContext?
            
            context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
            let newTask = NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: context!)
                
      //      let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
            newTask.setValue(task.id, forKey: "taskId")
            newTask.setValue(task.name, forKey: "taskName")
                
            do {
                try context?.save()
            }
            catch {
                    //error
                print ("There was an error while save context")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
