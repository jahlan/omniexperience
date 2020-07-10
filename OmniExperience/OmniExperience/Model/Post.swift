//
//  Post.swift
//  OmniExperience
//
//  Created by Yalan Bravo Olvera on 05/07/20.
//  Copyright © 2020 Yalan Bravo. All rights reserved.
//

import Foundation

class Post {
    var id : String
    var title : String
    var author : String
    var date : Int
    var thumbnail : String?
    var numberOfComments : Int
    var unreadStatus : Bool
    
    init(_ id: String, title: String, author: String, date: Int, thumbnail: String?, numberOfComments: Int, unreadStatus: Bool){
        self.id = id
        self.title = title
        self.author = author
        self.date = date
        self.thumbnail = thumbnail
        self.numberOfComments = numberOfComments
        self.unreadStatus = unreadStatus
    }
    
}
