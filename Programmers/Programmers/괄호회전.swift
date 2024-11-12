//
//  괄호회전.swift
//  Programmers
//
//  Created by root0 on 11/12/24.
//

import Foundation

func isCorrectStringBracket(_ s: String) -> Bool {
    let pair: [String: Character] = [
        ")" : "(",
        "}" : "{",
        "]" : "["
    ]
    var bracket = ""
    for brkt in s {
        let char = "\(brkt)"
        switch char {
        case "(", "{", "[":
            bracket.append(char)
        case ")", "}", "]":
            if bracket.last == pair[char] {
                bracket.removeLast()
            } else {
                bracket.append(char)
            }
        default:
            break
        }
    }

    return bracket.isEmpty
}

func rotateBracket(_ s: String) -> Int {

    let arrStr = Array(s)
    var result: Int = 0
    for i in 0..<arrStr.count {
        let remainStr = arrStr[i..<arrStr.count].reduce("") { $0 + "\($1)" }
        let preStr = s.prefix(i)

        let mutateStr = remainStr + preStr

        if isCorrectStringBracket(mutateStr) {
            result += 1
        }
    }

    return result
}
