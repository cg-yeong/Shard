//
//  OtherChatProfileView.swift
//  GroupBox
//
//  Created by root0 on 8/8/24.
//

import SwiftUI


public struct ChatOtherProfileView<ContentView: View>: View {
    
    public let content: ContentView

    public init(@ViewBuilder content: @escaping () -> ContentView) {
        self.content = content()
    }

    public var body: some View {
        ZStack(alignment: .top) {
            HStack(alignment: .top, spacing: 0) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 42, height: 42)
                    .cornerRadius(21)
                    .overlay {
                        Circle()
                            .stroke(Color.gray, lineWidth: 1)
                    }
                    .shadow(color: .black.opacity(0.24), radius: 6, x: 0, y: 2)
                    .onTapGesture {

                    }

                HStack(alignment: .bottom, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("닉네임은여덟글자")
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                            .padding(.top, 2)
                            .padding(.leading, 8)

                        content
                    }
                }
            }
            .padding(.leading, 12)
            .padding(.trailing, 16)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ChatOtherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ChatOtherProfileView {
            HStack(alignment: .bottom, spacing: 0) {
                Text("Pretty good. What are you doing this weekend?")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
                    .padding(.trailing, 24)
                    .padding(.vertical, 8)
                    .background(.secondary)
                    .cornerRadius(17.5, corners: [.topRight, .bottomLeft, .bottomRight])
                    .padding(.top, 2)

                Text("AM 11:12")
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .padding(.leading, 6)
            }
            .padding(.top, 2)
            .padding(.leading, 8)
        }
//        .padding(.trailing, 16)
    }
}

public extension View {

    @inlinable
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CornerRadiusStyle(radius: radius, corners: corners))
    }
}
public struct CornerRadiusStyle: Shape {

    public let radius: CGFloat
    public let corners: UIRectCorner

    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        return Path(path.cgPath)
    }
}
