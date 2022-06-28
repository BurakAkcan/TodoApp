//
//  ViewController.swift
//  Todo App(Realm)
//
//  Created by Burak AKCAN on 27.06.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var tableView:UITableView!
 //  var data:[Task] = [ Task(name: "deneme", time: Date()),Task(name: "try", time: Date())  ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTask))
        
       
        tableView.delegate = self
        tableView.dataSource = self
        print("\(vm.tasks.count) ***************")
     }
    override func viewWillAppear(_ animated: Bool) {
        vm.loadTask {
            tableView.reloadData()
        }
    }
    
    let vm = TodoViewModel.sharedInstance
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(vm.tasks.count)  return section olan  ")
        return vm.tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "dd//MM/yyyy hh:mm:ss"
        
        let data = vm.tasks[indexPath.row]
        
        cell.textLabel?.text = data.name
        let timeString = dateFormetter.string(from: data.time) //İşe yarar!!
        cell.detailTextLabel?.text = timeString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "toEdit") as! EditTaskViewController
        
        vc.task = vm.tasks[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        vm.deleteTask(task: vm.tasks[indexPath.row], taskIndex: indexPath.row) {
            print("Delete task")
            self.tableView.reloadData()
        }
    }
   


}

extension ViewController {
   @objc  func addButton(){
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddTask") as! AddTaskVC
       navigationController?.pushViewController(vc, animated: true)
    }
    @objc func deleteTask(){
        vm.deleteAll()
        vm.tasks = [Task]()
        tableView.reloadData()
    }
}
