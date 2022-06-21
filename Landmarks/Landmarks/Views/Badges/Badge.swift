//
//  Badge.swift
//  Landmarks
//
//  Created by root0 on 2022/06/17.
//

import SwiftUI

struct Badge: View {
    var badgeSymbols: some View {
        ForEach(0 ..< 8) { index in
            RotatedBadgeSymbol(angle: Angle.degrees(Double(index) / Double(8) * 360.0))
        }
        .opacity(0.5)
    }
    
    var body: some View {
        ZStack {
            BadgeBackground()
            
            GeometryReader { geometry in
                badgeSymbols
                    .scaleEffect(0.25, anchor: .top)
                    .position(x: geometry.size.width / 2, y: 0.75 * geometry.size.height)
            }
        }
        .scaledToFit()
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
