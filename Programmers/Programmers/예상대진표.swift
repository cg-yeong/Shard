//
//  예상대진표.swift
//  Programmers
//
//  Created by root0 on 11/5/24.
//

import Foundation

func estimatedMatch(_ n:Int, _ a:Int, _ b:Int) -> Int {
    var answer = 0
    var users = n
    var (userA, userB) = a < b ? (a, b) : (b, a)

    while users / 2 > 0 {
        answer += 1
        if (userA % 2 == 1) && (userB == userA + 1) {
            break
        }
        users = users / 2
        userA = userA % 2 == 0 ? userA / 2 : userA / 2 + 1
        userB = userB % 2 == 0 ? userB / 2 : userB / 2 + 1
    }
    return answer
}

