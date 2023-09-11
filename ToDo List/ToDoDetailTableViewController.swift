//
//  ToDoDetailTableViewController.swift
//  ToDo List
//
//  Created by Nikolai Eremenko on 04.06.2023.
//

import UIKit

private let dateFormatter: DateFormatter = {
    print("I JUST CREATED A DATEFORMATTER!")
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter
}()

class ToDoDetailTableViewController: UITableViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteView: UITextView!
    @IBOutlet weak var remainderSwitch: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    
    var toDoItem: ToDoItem!
    
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextVeiwIndexPath = IndexPath(row: 0, section: 2)
    let datePickerBottomIndexPath = IndexPath(row: 2, section: 1)
    let dateIndexPath = IndexPath(row: 0, section: 1)
    let dateRowHeight: CGFloat = 46
    let notesRowHeight: CGFloat = 200
    let datePickerBottomRowHeigh: CGFloat = 16
    let defaultRowHeight: CGFloat = 62
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the keyborde when the user taps outside of the text field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        nameField.delegate = self
        
        if toDoItem == nil {
            toDoItem = ToDoItem(name: "", date: Date().addingTimeInterval(24*60*60), notes: "", remainderSet: false, complited: false)
            nameField.becomeFirstResponder()
        }
        
        updateUserInterface()
    }
    
    func updateUserInterface() {
        nameField.text = toDoItem.name
        datePicker.date = toDoItem.date
        noteView.text = toDoItem.notes
        remainderSwitch.isOn = toDoItem.remainderSet
        dateLabel.textColor = (remainderSwitch.isOn ? .black : .gray)
        dateLabel.text = dateFormatter.string(from: toDoItem.date)
        tableView.separatorStyle = .none
        enableDisableSaveButton(text: nameField.text!)
        updateRemainderSwitch()
    }
    
    func updateRemainderSwitch() {
        LocalNotificationManager.isAuthorized { (authorized) in
            DispatchQueue.main.async {
                if !authorized && self.remainderSwitch.isOn {
                    self.oneButtonAlert(title: "User Has Not Allowed Notifications", message: "To receive alerts for reminders, open the Settings app, select To Do List > Notifications > Allow Notifications")
                    self.remainderSwitch.isOn = false
                }
                self.view.endEditing(true)
                self.dateLabel.textColor = (self.remainderSwitch.isOn ? .black : .gray)
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = ToDoItem(name: nameField.text!, date: datePicker.date, notes: noteView.text, remainderSet: remainderSwitch.isOn, complited: toDoItem.complited)
    }
    
    func enableDisableSaveButton(text: String) {
        if text.count > 0 {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func remainderSwitchChanged(_ sender: UISwitch) {
        updateRemainderSwitch()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        self.view.endEditing(true)
        dateLabel.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func nameFieldEditingChanged(_ sender: UITextField) {
        enableDisableSaveButton(text: sender.text!)
    }
}

extension ToDoDetailTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return remainderSwitch.isOn ? datePicker.frame.height : 0
        case notesTextVeiwIndexPath:
            return notesRowHeight
        case datePickerBottomIndexPath:
            return datePickerBottomRowHeigh
        case dateIndexPath:
            return dateRowHeight
        default:
            return defaultRowHeight
        }
    }
}

extension ToDoDetailTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        noteView.becomeFirstResponder()
        return true
    }
}
