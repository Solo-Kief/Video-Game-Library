//  main.swift
//  Video Game Library
//
//  Created by Solomon Keiffer on 8/30/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.
//
//  Functions as the library.

import Foundation

var gameList: [Game] = []

gameList.append(Game.init(name: "Ninjabread Man"))
gameList.append(Game.init(name: "How To Be A Complete Bastard"))
gameList.append(Game.init(name: "Touch Dic"))
gameList.append(Game.init(name: "If It Moves, Shoot It!"))
gameList.append(Game.init(name: "Big Mutha Truckers 2: Truck Me Harder"))
gameList.append(Game.init(name: "Zombies Ate My Neighbors"))
gameList.append(Game.init(name: "Chemist Tycoon"))
gameList.append(Game.init(name: "Ship Simulator 2008"))

func addGame() {
    print("Please enter the name of the game you wish to add: ", terminator: "")
    let newGame = readLine()
    gameList.append(Game.init(name: newGame!))
}

func removeGame() {
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

func listGames() {
    print("The are the currently avaliable games:\n")
    for (i, game) in gameList.enumerated(){
        if !game.isCheckedOut{
            print("\(i + 1). \(game.name)")
        }
    }
    print("")
}

func listCheckedOutGames() {
    print("The are the currently checked-out games.\n")
    for game in gameList{
        if game.isCheckedOut{
            print(game.name)
        }
    }
    print("")
}

func checkOut() {
    print("What game would you like to check out?")
    let input = readLine()!
    for game in gameList {
        if game.name.lowercased() == input.lowercased() {
            game.isCheckedOut = true
            let format = DateFormatter()
            format.dateStyle = DateFormatter.Style.long
            game.dueDate = Date.init(timeIntervalSinceNow: 1209600)
            print("\(game.name) has been checked out and is due by \(format.string(from: game.dueDate)).")
            return
        }
        else if let input = Int(input){
            if input > 0 && input < gameList.count + 1 {
                gameList[input - 1].isCheckedOut = true
                let format = DateFormatter()
                format.dateStyle = DateFormatter.Style.long
                gameList[input].dueDate = Date.init(timeIntervalSinceNow: 1209600)
                print("\n\"\(gameList[input].name)\" has been checked out and is due by \(format.string(from: gameList[input].dueDate)).")
                return
            }
        }
    }
    print("No such game exists in the repository.")
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
            print("This option will provide information about avaliable user commands.")
            print("Way to create a paradox, dumbass.")
        case 8:
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
            7. Help
            8. Quit

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
                help()
            case 8:
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
