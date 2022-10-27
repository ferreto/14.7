//
//  ViewController.swift
//  14.7
//
//  Created by Admin on 19.10.2022.
//

import UIKit

class UDViewController: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfFio: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tfName.text = Persistance.shared.name
        tfFio.text = Persistance.shared.fio
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Persistance.shared.name = tfName.text!
        Persistance.shared.fio = tfFio.text!
    }
    
    


}

