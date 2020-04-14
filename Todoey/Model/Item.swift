//
//  Item.swift
//  Todoey
//
//  Created by Hussein Qabalan on 4/10/20.
//  Copyright © 2020 Hussein Qabalan. All rights reserved.
//

import Foundation


class Item : Codable {
    var title : String = ""
    var done : Bool = false
    
    init() {}
    
    init(title : String, done: Bool) {
        self.title = title
        self.done = done
    }
}
