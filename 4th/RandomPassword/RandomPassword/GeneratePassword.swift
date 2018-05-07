//
//  GeneratePassword.swift
//  RandomPassword
//
//  Created by Lê Viết Mẫn on 8/7/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Foundation

private let characters = Array("0123456789abcdefghijklmnopqrstuvwxyz" +  "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

func generateRandomString(length: Int) -> String {
    var string = ""
    for index in 0..<length {
        string += String(generateRandomCharacter())
    }
    return string
}

private func generateRandomCharacter() -> Character {
    let index = Int(arc4random_uniform(UInt32(characters.count)))
    return characters[index];
}