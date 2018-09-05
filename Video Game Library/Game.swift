//  Game.swift
//  Video Game Library
//
//  Created by Solomon Keiffer on 8/30/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//
//  Framwork for storing game data.

import Foundation

class Game {
    let name: String
    var dueDate: Date
    var isCheckedOut: Bool
    
    init(name: String) {
        self.name = name
        self.dueDate = Date()
        self.isCheckedOut = false
    }
}
