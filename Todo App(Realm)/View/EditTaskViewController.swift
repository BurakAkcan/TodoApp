//
//  EditTaskViewController.swift
//  Todo App(Realm)
//
//  Created by Burak AKCAN on 28.06.2022.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    
    let vm = TodoViewModel.sharedInstance

    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var txtField:UITextField!
    
    var task:Task?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let mytask = task {
            txtField.text = mytask.name
            datePicker.date = mytask.time
        }
    }
    
    @IBAction func editButton(_ sender:Any){
        let newTask = Task(name: txtField.text ?? "", time: datePicker.date)
        vm.editTask(task: task!, updateTask: newTask) {
            navigationController?.popViewController(animated: true)
        }
    }

}
