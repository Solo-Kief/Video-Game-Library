//  main.swift
//  Video Game Library
//
//  Created by Solomon Keiffer on 8/30/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//
//  Functions as the menu/library.

import Foundation

var gameList: [Game] = []
var accountList: [Account] = []
var isLoggedIn = false
var currentUser: Account = Account(userName: "Null", password: "", birthday: Date())

gameList.append(Game.init(name: "Ninjabread Man", rating: 4))
gameList.append(Game.init(name: "How To Be A Complete Bastard", rating: 4))
gameList.append(Game.init(name: "Touch Dic", rating: 1))
gameList.append(Game.init(name: "If It Moves, Shoot It!", rating: 4))
gameList.append(Game.init(name: "Big Mutha Truckers 2: Truck Me Harder", rating: 5))
gameList.append(Game.init(name: "Zombies Ate My Neighbors", rating: 3))
gameList.append(Game.init(name: "Chemist Tycoon", rating: 2))
gameList.append(Game.init(name: "Ship Simulator 2008", rating: 1))

func addGame() {
    if isLoggedIn && currentUser.isAdmin {
        print("Please enter the name of the game you wish to add: ", terminator: "")
        let newGame = readLine()
        print("Please enter the game's rating. 0 = EC | 1 = E | 2 = E-10 | 3 = T | 4 = M | 5 = AO")
        if let rating = Int(readLine()!) {
            gameList.append(Game.init(name: newGame!, rating: rating))
        }
        else {
            print("Failed to add game due to inappropriate rating value.")
        }
    }
    else {print("User must be admin.")}
}

func removeGame() {
    if isLoggedIn && currentUser.isAdmin {
        print("Please enter the name or index of the game you wish to remove: ", terminator: "")
        let rGame = readLine()
        var i = -1
        var mark = -1
        for game in gameList {
            i += 1
            if game.name.lowercased() == rGame?.lowercased() {
                mark = i
                print("\(game.name) has been removed.\n")
            }
        }
        
        if let suppose = Int(rGame!) {
            if suppose > 0 && suppose < gameList.count + 1{
                mark = suppose - 1
                print("\n\"\(gameList[mark].name)\" has been removed.\n")
            }
        }
        
        guard mark != -1 else {
            return print("Game does not appear in the repository.")
        }
        guard !gameList[mark].isCheckedOut else {
            return print("You cannnot remove a game that is currently checked out.")
        }
        
        gameList.remove(at: mark)
    }
    else {print("User must be admin.")}
}

func listGames() {
    print("These are the currently avaliable games:\n")
    for (i, game) in gameList.enumerated(){
        if !game.isCheckedOut{
            print("\(i + 1). \(game.name) | Rated: \(game.rating)")
        }
    }
    print("")
}

func listCheckedOutGames() {
    print("These are the currently checked-out games:\n")
    for game in gameList{
        if game.isCheckedOut{
            print(game.name)
        }
    }
    print("")
}

func checkOut() {
    if isLoggedIn {
        print("What game would you like to check out?")
        let input = readLine()!
        for game in gameList {
            if game.name.lowercased() == input.lowercased() {
                if currentUser.isLegal(game: game) {
                    game.isCheckedOut = true
                    let format = DateFormatter()
                    format.dateStyle = DateFormatter.Style.long
                    game.dueDate = Date.init(timeIntervalSinceNow: 1209600)
                    print("\(game.name) has been checked out and is due by \(format.string(from: game.dueDate)).")
                    return
                }
                else {return print("You are not old enough to check out this game.")}
            }
            else if let input = Int(input){
                if input > 0 && input < gameList.count + 1 {
                    if currentUser.isLegal(game: game) {
                        gameList[input - 1].isCheckedOut = true
                        let format = DateFormatter()
                        format.dateStyle = DateFormatter.Style.long
                        gameList[input].dueDate = Date.init(timeIntervalSinceNow: 1209600)
                        print("\n\"\(gameList[input].name)\" has been checked out and is due by \(format.string(from: gameList[input].dueDate)).")
                        return
                    }
                    else {return print("You are not old enough to check out this game.")}
                }
            }
        }
        print("No such game exists in the repository.")
    }
    else {print("You must be logged in to check out a game.")}
}

func checkIn() {
    print("What game would you like to check in?")
    let input = readLine()!
    for game in gameList {
        if game.name.lowercased() == input.lowercased() {
            game.isCheckedOut = false
            game.dueDate = Date()
            print("\(game.name) has been checked in.")
            return
        }
    }
    print("No such game exists in the repository.")
}

func help() {
    print("What command do you need help with? (Option Number)")
    let input = readLine()
    if let request: Int = Int(input!) {
        switch request {
        case 1:
            print("This option will add a game to the repository.")
        case 2:
            print("This option will perminantly remove a game from the repository")
        case 3:
            print("This option will list all the games in the repository that are not checked out.")
        case 4:
            print("This option will list all games that are currently checked out of the repository.")
        case 5:
            print("This option will allow you to check out a game.")
        case 6:
            print("This option will allow you to check in a game.")
        case 7:
            print("This option will allow you to make a new account.")
        case 8:
            print("This option will log an existing user in.")
        case 9:
            print("This option will log out the current user.")
        case 10:
            print("This option will make the currently logged in account an administrator.")
        case 11:
            print("This option will provide information about avaliable user commands.")
            print("Way to create a paradox, dumbass.")
        case 12:
            print("This option will terminate the current session.")
        default:
            print("\nYou entered an invalid option. Please make a selection 1 - 8.\n")
        }
    }
    else {
        print("\nYou entered an invalid option. Please make a selection 1 - 8\n")
    }
    print("")
}

func makeAccount() {
    print("Please choose a username...")
    let userName = readLine()
    
    print("Please create a password...")
    let password = readLine()
    
    print("Please enter your birthday with format (Nov 23, 1937)")
    let format = DateFormatter()
    format.dateStyle = DateFormatter.Style.medium
    
    guard let birthday = format.date(from: readLine()!) else {
        return print("Invalid date given or inavalid date format used.")
    }
    
    accountList.append(Account.init(userName: userName!, password: password!, birthday: birthday))
    print("Your new account has been made.")
}

func login(){
    print("Please enter your user name.")
    let userName = readLine()
    
    for account in accountList {
        if account.userName == userName {
            print("Please enter your password.")
            let password = readLine()!
            if account.verifyPassword(password: password) {
                isLoggedIn = true
                currentUser = account
                return print("User \(account.userName) has successfully logged in.")
            }
            return print("Incorrect Password.")
        }
    }
    return print("No such user name was found.")
}

func makeAdmin(){
    if isLoggedIn {
        print("Please enter the admin password.")
        let password = readLine()!
        if currentUser.makeAdmin(Administrative_Password: password) {
            print("User has been made an admin.")
        }
        else {print("Given password was incorrect.")}
    }
    else {print("User must be logged in.")}
}

func logout() {
    isLoggedIn = false
    currentUser = Account.init(userName: "Null", password: "", birthday: Date())
}

func run() {
    var finished = false
    while !finished {
        print("""
            Main Menu:
            
            1. Add Game
            2. Remove Game
            3. List Avaliable Games
            4. List Checked Out Games
            5. Check Out a Game
            6. Check In a Game
            7. Make an Account
            8. Log-In
            9. Log-Out
            10. Make Account Administrative
            11. Help
            12. Quit

            """)
        let input = readLine()
        if let request: Int = Int(input!) {
            switch request {
            case 1:
                addGame()
            case 2:
                removeGame()
            case 3:
                listGames()
            case 4:
                listCheckedOutGames()
            case 5:
                checkOut()
            case 6:
                checkIn()
            case 7:
                makeAccount()
            case 8:
                login()
            case 9:
                logout()
            case 10:
                makeAdmin()
            case 11:
                help()
            case 12:
                print("\nThank you for using the video game library.\n")
                finished = true
            default:
                print("\nYou entered an invalid option. Please make a selection 1 - 8.\n")
            }
        }
        else {
            print("\nYou entered an invalid option. Please make a selection 1 - 8.\n")
        }
    }
}

run()
