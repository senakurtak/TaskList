//
//  RealmHandler.swift
//  BauBuddyTaskList
//
//  Created by Sena Kurtak on 15.02.2023.
//

import Foundation
import UIKit
import RealmSwift

class RealmHandler{
    
    static let shared = RealmHandler()
    let realm = try! Realm()
    
    func saveData(dataItems : [Task]){
        do {
            try realm.write{
                for dataItem in dataItems {
                    let savedItem = SavedTask()
                    savedItem.task = dataItem.task
                    savedItem.descriptionTask = dataItem.descriptionTask
                    savedItem.colorCode = dataItem.colorCode
                    savedItem.title = dataItem.title
                    realm.add(savedItem)
                }
            }
            print("success on realswift saving issues")
        } catch {
            print("Error on saving data")
        }
    }
    
    func deleteAllData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
            print("success on realswift deleting issues")
            
        } catch {
            print("Error deleting all data: \(error.localizedDescription)")
        }
    }
    
    func fetchLocalData() -> [Task] {
        self.realm.beginWrite()
        let savedTask = self.realm.objects(SavedTask.self)
        try! realm.commitWrite()
        let result = Array(savedTask).map { item in
            Task(task: item.task, title: item.title, descriptionTask: item.descriptionTask, colorCode: item.colorCode)
        }
        return result
        print("success on realswift fetching issues")
    }
    
}
