//
//  DetailViewController.swift
//  Todo App(Realm)
//
//  Created by Burak AKCAN on 27.06.2022.
//

import UIKit
import RealmSwift



class AddTaskVC: UIViewController {
    @IBOutlet weak var txtTaskName:UITextField!
    @IBOutlet weak var datePicker:UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func saveButton(_ sender:Any){
        print("saving task")
        if  txtTaskName.text != "" && txtTaskName.text?.isEmpty == false {
 
            let vm = TodoViewModel.sharedInstance
            let task = Task(name: txtTaskName.text!, time: datePicker.date)
            
            
            vm.addTask(add: task) {

                self.navigationController!.popViewController(animated: true)
        }
       
        }else{
            let ac = UIAlertController(title: "Error", message: "Fill in the text field", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(ac, animated: true)
        }
    }
    
    
    
    

 
}
