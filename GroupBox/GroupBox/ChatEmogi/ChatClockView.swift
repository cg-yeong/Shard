//
//  ChatClockView.swift
//  GroupBox
//
//  Created by root0 on 8/8/24.
//

import SwiftUI

public struct ClockView: View {
    public let time: Int

    public init(time: Int) {
        self.time = time
    }

    public var body: some View {
        Text(time.makeLocaleTimeEn(is24Format: true))
            .font(.body)
            .foregroundColor(.gray)
            .lineLimit(1)
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(time: 1710311370)
    }
}

public extension Int {

    func makeLocaleTimeEn(is24Format: Bool = false) -> String {
        let timeInterval = TimeInterval(self)
        let timeDate = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = is24Format ? "a HH:mm" : "a hh:mm"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.timeZone = .current

        return dateFormatter.string(from: timeDate)
    }

    func makeLocaleTimeDate(isLTR: Bool = true) -> String {

        let timeInterval = TimeInterval(self)

        let timeDate = Date(timeIntervalSince1970: timeInterval)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current

        if !isLTR {
            dateFormatter.locale = Locale(identifier: "en")
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
        }

        return dateFormatter.string(from: timeDate)
    }

    func makeLocaleDate(isLTR: Bool = true) -> String {

        let timeInterval = TimeInterval(self)

        let timeDate = Date(timeIntervalSince1970: timeInterval)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current

        if !isLTR {
            dateFormatter.locale = Locale(identifier: "en")
        }

        return dateFormatter.string(from: timeDate)
    }
}
