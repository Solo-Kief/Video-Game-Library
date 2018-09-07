//  Game.swift
//  Video Game Library
//
//  Created by Solomon Kieffer on 8/30/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//
//  Framwork for storing game data.

import Foundation

class Game {
    let name: String
    var dueDate: Date
    var isCheckedOut: Bool
    let rating: String
    
    init(name: String, rating: Int) {
        self.name = name
        self.dueDate = Date()
        self.isCheckedOut = false
        
        switch rating {
        case 0:
            self.rating = "EC"
        case 1:
            self.rating = "E"
        case 2:
            self.rating = "E-10"
        case 3:
            self.rating = "T"
        case 4:
            self.rating = "M"
        case 5:
            self.rating = "AO"
        default:
            self.rating = "Unrated"
        }
    }
}
