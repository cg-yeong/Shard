//
//  의상or위장.swift
//  Programmers
//
//  Created by root0 on 11/28/24.
//

import Foundation

func getLookBooksCount(_ clothes:[[String]]) -> Int {
    var closet: [String: [String]] = [:]

    for cloth in clothes {
        let name = cloth[0]
        let category = cloth[1]
        closet[category, default: []].append(name)
    }
    print("\(closet)\n")

    var lookBooks = 1
    for (key, value) in closet {
        print("(\"undressed\"), \(value)")
        lookBooks *= value.count + 1
    }

    print("== end ==")
    return lookBooks - 1
}

/*
getLookBooksCount([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"]]) //5
getLookBooksCount([["crow_mask", "face"], ["blue_sunglasses", "face"], ["smoky_makeup", "face"]]) //3
getLookBooksCount([["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"], ["blue_jeans", "pants"]]) // 2 + 1 + 1 + (2ab+2ac+1bc) + (2 * abc) = 11? 2 * 1 * 1 * 3
*/
