//  Accounts.swift
//  Video Game Library
//
//  Created by Solomon Kieffer on 9/6/18.
//  Copyright © 2018 Phoenix Development. All rights reserve
//
//  Framework for making and storing account data.

import Foundation

class Account {
    let userName: String
    let birthday: Date
    private var password: String
    var isAge18: Bool
    var isAdmin = false
    
    init(userName: String, password: String, birthday: Date) {
        self.userName = userName
        self.password = password
        self.birthday = birthday
        
        if birthday.timeIntervalSince1970 - Date().timeIntervalSince1970 > 567648000 {
            isAge18 = true
        }
        else {
            isAge18 = false
        }
    }
    
    func evaluate() -> Int {
        if Date().timeIntervalSince1970 - birthday.timeIntervalSince1970 >= 567648000 {
            isAge18 = true
            return Int(birthday.timeIntervalSince1970)
        }
        else {
            isAge18 = false
            return Int(birthday.timeIntervalSince1970)
        }
    }
    
    func isLegal(game: Game) -> Bool {
        switch game.rating {
        case "T":
            return self.evaluate() >= 409968000
        case "M":
            self.evaluate()
            return self.isAge18
        case "AO":
            return self.evaluate() >= 662256000
        default:
            return true
        }
    }
    
    func changePassword(currentPassword: String, newPassword: String, verifyNewPassword: String) -> Bool {
        if currentPassword == self.password {
            if newPassword == verifyNewPassword{
                self.password = newPassword
                return true
            }
            else {
                print("Passwords did not match.")
                return false
            }
        }
        else {
            print("The given password was incorrect.")
            return false
        }
    }
    
    func verifyPassword(password: String) -> Bool {
        return self.password == password
    }
    
    func makeAdmin(Administrative_Password: String) -> Bool {
        if Administrative_Password == "p4c1" {
            isAdmin = true
            return true
        }
        return false
    }
}
