//
//  CustomViewModel.swift
//  BauBuddyTaskList
//
//  Created by Sena Kurtak on 14.02.2023.
//

import Foundation
import UIKit
import RealmSwift

protocol TasksViewModelDelegate {
    func onSuccessfullTaksLoaded()
}

class CustomViewModel {
    
    var taskList = [Task]()
    var realmTaksList = [Task]()
    var delegate : TasksViewModelDelegate?
    let networkManager = NetworkManager()
    var handler = RealmHandler()
    
    func getTasks(){
        NetworkManager.shared.loginRequest { result in
            switch result {
            case .success(let success):
                NetworkManager.shared.fetchTasks(with: success) { task in
                    self.taskList = task
                    DispatchQueue.main.async {
                        self.delegate?.onSuccessfullTaksLoaded()
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func realmSaveTask(tasks : [Task]){
        handler.saveData(dataItems: tasks)
        print("realmSaveTask function worked")
    }
    
    func realmDeleteAllTask(){
        handler.deleteAllData()
        print("realmDeleteAllTask function worked")

    }
    
    func realmFetchTaks() -> [Task] {
        realmTaksList = handler.fetchLocalData()
        return realmTaksList
        print("realmFetchTaks function worked")
    }
}
