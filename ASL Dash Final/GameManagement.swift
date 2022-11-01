//
//  GameManagement.swift
//  ASL Dash Final
//
//  Created by Katherine Byunn-Rieder.
//

import Foundation
import UIKit

struct Game {
    //we will need to access
    var score = 0
    var currSign = (image: "ASLA", letter: Character("A"), level: 1)
    var arrForLevel: [(image: String, letter: Character, level: Int)] = []

    //CALL
    mutating func setup(level: Int) {
        let arr = setupData()
        if level <= 5 {
            makeArrForLevel(level: level, arr: arr)
        } else if level == 6 {
            makeArrForLevel(level: 1, arr: arr)
            makeArrForLevel(level: 2, arr: arr)
            makeArrForLevel(level: 3, arr: arr)
        } else if level == 7 {
            makeArrForLevel(level: 4, arr: arr)
            makeArrForLevel(level: 5, arr: arr)
        } else if level == 8 {
            arrForLevel = arr
        }
        getNewSignIndex(arr: arrForLevel)
    }
    
    mutating func makeArrForLevel(level: Int, arr: [(image: String, letter: Character, level: Int)]){
        for num in 0..<arr.count { //26
            if (level == arr[num].level){
                arrForLevel.append(arr[num])
            }
        }
    }
    
    //called
    mutating func setupData() -> [(image: String, letter: Character, level: Int)] {
        let charactersPerLev = 5.0
        var signArray: [(image: String, letter: Character, level: Int)] = []
        var i = 0.6
        for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            signArray.append(("ASL\(char)", char, Int(i.rounded(.toNearestOrAwayFromZero))))
            i += 1/charactersPerLev //so it increments character per level times before switching rounded values
        }
        //the exception to charactersPerLevel
        signArray[signArray.count - 1].level = 5
        return signArray
    }
    
    //called
    mutating func getNewSignIndex (arr:[(image: String, letter: Character, level: Int)]){
        let index = Int.random(in: 1..<arr.count)
        currSign = arr[index]
    }
}
