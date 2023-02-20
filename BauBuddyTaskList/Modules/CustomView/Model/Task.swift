//
//  Task.swift
//  BauBuddyTaskList
//
//  Created by Sena Kurtak on 14.02.2023.
//

import Foundation

struct Task : Decodable{
    
    var task : String?
    var title : String?
    var descriptionTask : String?
    var colorCode : String?
    
    enum CodingKeys: String, CodingKey {
        
        case task
        case title
        case descriptionTask = "description"
        case colorCode
        
    }
}
