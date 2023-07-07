//
//  ToDoItem.swift
//  ToDo List
//
//  Created by Nikolai Eremenko on 22.06.2023.
//

import Foundation

struct ToDoItem: Codable {
    var name: String
    var date: Date
    var notes: String
    var remainderSet: Bool
    var notificationID: String?
    var complited: Bool
}
