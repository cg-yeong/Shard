//
//  H-Index.swift
//  Programmers
//
//  Created by root0 on 11/28/24.
//

import Foundation

func recommend_h_index(_ citations:[Int]) -> Int {
    let citations = citations.sorted() { $0 > $1 }
    var h_index = 0

    for i in 0 ..< citations.count {
        if i + 1 <= citations[i] {
            h_index = i + 1
        } else {
            break
        }
    }

    return h_index
}


func try1_h_index(_ citations:[Int]) -> Int {
    var h = citations.count
    var h_index = 0

    while h > 0 {
        h_index = citations.filter { $0 >= h }.count
        print("\(h): \(h_index)")

        if h <= h_index {
            break
        } else {
            h -= 1
        }

    }
    print("== end ==")
    return h
}
