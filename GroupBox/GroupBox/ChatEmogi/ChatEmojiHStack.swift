//
//  ChatEmojiHStack.swift
//  GroupBox
//
//  Created by root0 on 8/8/24.
//

import SwiftUI

struct Emoji: Identifiable {
    let id: UUID = UUID()
    let unicode: String = ""
}
enum EmojiReaction: String, CaseIterable {

    case heart = "\u{2764}"
    case thumbsUp = "\u{1F44D}"
    case check = "\u{2714}"
    case congratulate = "\u{1F389}"
    case fallInLove = "\u{1F60D}"
    case laugh = "\u{1F923}"
    case sad = "\u{1F972}"

    var unicode: String { rawValue }
}

struct ChatEmojiStack: View {

    @Binding var emojis: [String]

    @Binding var isAppear: Bool

    var body: some View {
        
        HStack {
            ForEach(emojis, id: \.self) { emoji in
                Text(emoji)
                    .font(.title)
            }
        }
        .padding()
        .background(Color(uiColor: UIColor.lightGray))
        .cornerRadius(20, corners: [.allCorners])
    }
}
// 하트, 엄지, 체크, 축하, 하트face, 웃음, 슬픔
#Preview {
    ChatEmojiStack(
        emojis: .constant(["\u{2764}", "\u{1F44D}", "\u{2714}", "\u{1F389}", "\u{1F60D}", "\u{1F923}", "\u{1F972}"]),
        isAppear: .init(get: {
            true
        }, set: { value in
            _ = value
        })
    )
}
