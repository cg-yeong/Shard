//
//  n^2배열자르기.swift
//  Programmers
//
//  Created by root0 on 11/13/24.
//

import Foundation

// Time Over And Fail
func plateArray(_ n: Int, _ left: Int64, _ right: Int64) -> [Int] {
    var marr: [[Int]] = Array(repeating: Array(repeating: 0, count: n), count: n)
    var cmpArr: [Int] = []
    for row in marr.indices {
        for col in marr[row].indices {
            marr[row][col] = col <= row ? row + 1 : col + 1
        }

        print(marr[row])
        cmpArr.append(contentsOf: marr[row])
    }
    print("=====\n\(cmpArr)\n")
    print(Array(cmpArr[Int(left)...Int(right)]))
    print("*** end ***\n")
    return Array(cmpArr[Int(left)...Int(right)])
}

// Correct
func getFromRemainderAndCoordinator(_ n: Int, _ left: Int64, _ right: Int64) -> [Int] {
    var result = [Int]()
    for idx in left...right {
        let row = Int(idx) / n
        let col = Int(idx) % n
        let element = max(row, col) + 1
        result.append(element)
    }

    return result
}
