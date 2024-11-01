//
//  ReactionStack.swift
//  Feature
//
//  Created by root0 on 8/12/24.
//  Copyright © 2024 GlobalHoneys. All rights reserved.
//

import SwiftUI

public struct Emoji: Identifiable, Hashable {
    public var id = UUID()
    public var unicode: String

    public init(_ unicode: String) {
        self.unicode = unicode
    }
}

public enum EmojiReaction: CaseIterable {
    case heart
    case thumbsUp
    case check
    case congratulate
    case fallInLove
    case lauth
    case sad

    public var unicode: String {
        switch self {
        case .heart: "\u{2764}"
        case .thumbsUp: "\u{1F44D}"
        case .check: "\u{2714}"
        case .congratulate: "\u{1F389}"
        case .fallInLove: "\u{1F60D}"
        case .lauth: "\u{1F923}"
        case .sad: "\u{1F972}"
        }
    }

    public var emoji: Emoji {
        Emoji(self.unicode)
    }
}


public struct ReactionStack<Content: View>: View {

    @Binding var reactions: [EmojiReaction]
    @Binding var showEmoji: Bool
    @Binding var selected: Emoji?

    let content: (Emoji) -> Content
 /*
  Button {
      print("emoji tap")
  } label: {
      Text(emoji.unicode)
  }
  */

    init(reactions: Binding<[EmojiReaction]>,
         showEmoji: Binding<Bool>,
         selected: Binding<Emoji?>,
         @ViewBuilder content: @escaping (Emoji) -> Content) {
        self._reactions = reactions
        self._showEmoji = showEmoji
        self._selected = selected

        self.content = content
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 2) {
            ForEach(reactions.map { $0.emoji }, id: \.self) { emoji in
                content(emoji)
                    .padding(4)
                    .background(emoji.unicode == selected?.unicode ? Color(red: 0.882, green: 0.882, blue: 0.882) : Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .opacity(showEmoji ? 1 : 0)
        .animation(.easeIn, value: showEmoji)
        .shadow(radius: 6, y: 2)
    }
}

#Preview {

    Color.white.overlay {
        ReactionStack(
            reactions: .constant( EmojiReaction.allCases ),
            showEmoji: .constant( true ),
            selected: .constant(EmojiReaction.congratulate.emoji),
            content: { emoji in
                Text(emoji.unicode)
                    .frame(width: 28, height: 28)
            }
        )
    }
}
