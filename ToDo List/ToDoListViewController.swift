//
//  ViewController.swift
//  ToDo List
//
//  Created by Nikolai Eremenko on 04.06.2023.
//

import UIKit

class ToDoListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    //Dummy data
    var toDoArray = ["Learn Swifrt", "Build Apps", "Change the World", "Take a Vacation"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = toDoArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    
}

