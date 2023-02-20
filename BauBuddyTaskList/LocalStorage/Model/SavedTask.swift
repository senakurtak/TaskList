//
//  SavedTask.swift
//  BauBuddyTaskList
//
//  Created by Sena Kurtak on 15.02.2023.
//

import Foundation
import RealmSwift

class SavedTask : Object {
    
    @objc dynamic var task : String?
    @objc dynamic var title : String?
    @objc dynamic var descriptionTask : String?
    @objc dynamic var colorCode : String?
    
}
