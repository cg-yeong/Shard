//
//  ContentView.swift
//  GroupBox
//
//  Created by root0 on 7/12/24.
//

import SwiftUI

struct ContentView: View {

    enum PopoverTarget {
        case otherchat0
        case text1
        case text2
        case text3
        case text4
    }

    @State private var popoverTarget: PopoverTarget?
    @Namespace private var nsPopover

    @State var selectedEmoji: Emoji? = nil

    @ViewBuilder
    private var customPopover: some View {
        if let popoverTarget = popoverTarget {
            ReactionStack(
                reactions: .constant( EmojiReaction.allCases ),
                showEmoji: .constant( true ),
                selected: .init(get: { selectedEmoji }, set: { new in selectedEmoji = new }),
                content: { emoji in
                    Button {
                        selectedEmoji = emoji
                        self.popoverTarget = nil
                    } label: {
                        Text(emoji.unicode)
                    }
                }
            )
            .matchedGeometryEffect(
                id: popoverTarget,
                in: nsPopover,
                properties: .position,
                isSource: false
            )
        }
    }

    private func popoverPlaceholder(
        target: PopoverTarget,
        xOffset: CGFloat = 0,
        yOffset: CGFloat = 0
    ) -> some View {
        Color.clear
            .matchedGeometryEffect(id: target, in: nsPopover)
            .offset(x: xOffset, y: yOffset)
    }

    private func showPopover(target: PopoverTarget) {
        withAnimation {
            if popoverTarget != nil {
                popoverTarget = nil
            } else {
                popoverTarget = target
            }
        }

    }

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                OtherTextMsgView()
                    .onTapGesture {
                        showPopover(target: .otherchat0)
                    }
                    .background(
                        GeometryReader { proxy in
                            let proxy = proxy.frame(in: .local)
                            popoverPlaceholder(target: .otherchat0,
                                               xOffset: -12,
                                               yOffset: proxy.midY)
                        }
                    )

                OtherTextMsgView()
                    .background(.blue)
                    .onTapGesture { showPopover(target: .text1) }
                    .background(
                        GeometryReader { proxy in
                            let proxy = proxy.frame(in: .local)
                            popoverPlaceholder(target: .text1,
                                               xOffset: -12,
                                               yOffset: proxy.midY)
                        }
                    )


                OtherTextMsgView()
                    .background(.orange)
                    .onTapGesture { showPopover(target: .text2) }
                    .background(
                        GeometryReader { proxy in
                            let proxy = proxy.frame(in: .local)
                            popoverPlaceholder(target: .text2,
                                               xOffset: -12,
                                               yOffset: proxy.midY)
                        }
                    )

                Spacer()

                OtherTextMsgView()
                    .background(.green)
                    .onTapGesture { showPopover(target: .text3) }
                    .background(
                        GeometryReader { proxy in
                            let proxy = proxy.frame(in: .local)
                            popoverPlaceholder(target: .text3,
                                               xOffset: -12,
                                               yOffset: proxy.midY)
                        }
                    )

                Spacer()

                OtherTextMsgView()
                    .background(.red)
                    .onTapGesture { showPopover(target: .text4) }
                    .background(
                        GeometryReader { proxy in
                            let proxy = proxy.frame(in: .local)
                            popoverPlaceholder(target: .text4,
                                               xOffset: -12,
                                               yOffset: -proxy.midY)
                        }
                    )

                Spacer()
            }

        }
        .overlay {

            customPopover
                .transition(
                    .opacity.combined(with: .scale)
                    .animation(.bouncy(duration: 0.25, extraBounce: 0.2))
                )
//                .transition(.slide.combined(with: .scale).animation(.easeInOut))
//                .transition(.move(edge: .leading).combined(with: .move(edge: .top)))
        }
        .foregroundStyle(.white)
        .contentShape(Rectangle())
        .onTapGesture {
            popoverTarget = nil
        }
    }
}

#Preview {
    ContentView()
}
