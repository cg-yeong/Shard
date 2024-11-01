//
//  ChatView.swift
//  GroupBox
//
//  Created by root0 on 8/13/24.
//

import SwiftUI

struct ChatView: View {
    @State var showContextMenu = false
    @State var longpressLocation = CGPoint.zero
    @GestureState var press = false

    @State private var popoverTarget: Int?
    @Namespace private var nsPopover



    var body: some View {
        VStack {
            // start

            ScrollView {
                VStack(spacing: 16) {

                    OtherTextMsgView()
                        .onTapGesture {
                            showPopover(target: 1)
                        }
                        .background(
                            GeometryReader { proxy in
                                let proxy = proxy.frame(in: .local)
                                Color.clear
                                    .matchedGeometryEffect(id: 1, in: nsPopover)
                                    .offset(x: -12, y: proxy.midY)
                            }
                        )
                        .id(1)
                    OtherTextMsgView()
                        .onTapGesture {
                            showPopover(target: 2)
                        }
                        .background(
                            GeometryReader { proxy in
                                let proxy = proxy.frame(in: .local)
                                popoverPlaceholder(target: 2, offsetX: -12, offsetY: proxy.midY)
                            }
                        )
                        .background(popoverPlaceholder(target: 2, offsetX:  -40 ,offsetY: -70))
                        .id(2)
                    OtherTextMsgView()
                        .onTapGesture {
                            showPopover(target: 3)
                        }
                        .background(popoverPlaceholder(target: 3, offsetY: -70))
                        .id(3)
                }
                .onTapGesture {
                    showContextMenu = false
                }

                Spacer()
            }
            .overlay {

                emojiPopover
                    .transition(
                        .opacity.combined(with: .scale)
                        .animation(.bouncy(duration: 0.25, extraBounce: 0.2))
                    )
            }


            // end zstack
        }
        .contentShape(Rectangle())
        .onTapGesture {
            popoverTarget = nil
        }

    }

    @ViewBuilder
    private var emojiPopover: some View {
        if let _ = popoverTarget {
            ReactionStack(
                reactions: .constant( EmojiReaction.allCases ),
                showEmoji: .constant( true ),
                selected: .constant(EmojiReaction.heart.emoji),
                content: { emoji in
                    Button {

                    } label: {
                        Text(emoji.unicode)
                    }
                }
            )
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(white: 0.95))
                    .shadow(radius: 6)
            )
            .matchedGeometryEffect(id: popoverTarget, in: nsPopover, properties: .frame, isSource: false)
        }


    }

    private func popoverPlaceholder(target: Int, offsetX: CGFloat = .zero, offsetY: CGFloat = .zero) -> some View {

        Color.clear
            .matchedGeometryEffect(id: target, in: nsPopover)
            .offset(x: offsetX, y: offsetY)
    }

    private func showPopover(target: Int) {
        if popoverTarget != nil {
            withAnimation {
                popoverTarget = nil
            }
        } else {
            popoverTarget = target
        }
    }
}

#Preview {
    ChatView()
}
