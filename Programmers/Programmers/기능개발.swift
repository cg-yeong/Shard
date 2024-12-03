//
//  기능개발.swift
//  Programmers
//
//  Created by root0 on 12/3/24.
//

import Foundation

func getDayCompleteTask(_ progress: Int, speed: Int) -> Int {
    var day = 0
    var now = progress

    while now < 100 {
        now += speed
        day += 1
    }
    return day
}

func distributeFeatures(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    guard !progresses.isEmpty else {
        return [0]
    }
    var estimatedTimes: [Int] = []
    for i in 0 ..< progresses.count {
        estimatedTimes.append(getDayCompleteTask(progresses[i], speed: speeds[i]))
    }

    var distributions: [Int] = []
    var dtb = estimatedTimes.first!
    var features: [Int] = []

    for task in estimatedTimes {
        if dtb >= task {
            features.append(task)

        } else {
            distributions.append(features.count)
            features = [task]
            dtb = task
        }
    }

    distributions.append(features.count)
    return distributions
}
