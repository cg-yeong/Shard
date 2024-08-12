//
//  OtherTextMsgView.swift
//  HoneyMessageView
//
//  Created by Gab on 2024/03/12.
//

import SwiftUI

public struct OtherTextMsgView: View {

    @State private var radius: CGFloat = 17.5

    @GestureState var press = false
    @State var showEmoji = false
    @State var selectedReaction: EmojiReaction?
    @State var presentedReaction: [EmojiReaction] = []

    public init() {
    }

    public var body: some View {
        ChatOtherProfileView {
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .bottom, spacing: 6) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("채팅내용은 챗컨텐츠 4.0")
                            .font(.body)
                            .foregroundColor(.primary)

                        if !"chatModel.myMsgCont".isEmpty {
                            HStack(alignment: .top, spacing: 4) {
                                Image(systemName: "arrow.rectanglepath")
                                    .font(.caption)

                                Text("채팅내용은 챗컨텐츠 4.0: 번역")
                                    .font(.caption)
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 24)
                    .padding(.vertical, 8)
                    .background(showEmoji ? .secondary : Color.purple)
                    .scaleEffect(press ? 2 : 1)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6))
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    let proxy = proxy.frame(in: .local)
                                    radius = proxy.height >= 20 ? 20 : 17.5
                                }
                        }
                    }
                    .cornerRadius(radius, corners: [.topRight, .bottomLeft, .bottomRight])
                    .gesture(
                        LongPressGesture(minimumDuration: 0.5)
                            .updating($press, body: { currentState, gestureState, transaction in
                                gestureState = currentState
                            })
                            .onEnded({ value in
                                showEmoji.toggle()
                            })
                    )



                    ClockView(time: 1710311370)
                }
                .overlay(alignment: .bottom) {
                    HStack(spacing: 5) {

                        ForEach(0 ..< EmojiReaction.allCases.count, id: \.self) { index in
                            let emoji = EmojiReaction.allCases[index]
                            Button {
                                showEmoji = false
                                selectedReaction = selectedReaction == emoji ? nil : emoji
                                if presentedReaction.contains(where: { $0  == emoji}) {
                                    presentedReaction.removeAll(where: { $0 == emoji})
                                } else {
                                    presentedReaction.append(emoji)
                                }
                            } label: {
                                Text(emoji.rawValue)
                            }
                            .frame(width: 35, height: 35)
                            .background(selectedReaction == emoji ? Color.gray.opacity(0.25) : Color.clear)
                            .clipShape(Circle())
    //                            .offset(y: showEmoji ? 0 : 40)
                            .animation(.easeInOut.delay(0.05 * Double(index)), value: showEmoji)

                        }
                    }
                    .padding(5)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .offset(y: 50)
                    .opacity(showEmoji ? 1 : 0)
                    .animation(.easeIn, value: showEmoji)
                    .zIndex(1)
                }
                .padding(.top, 4)
                .padding(.leading, 8)


                HStack(spacing: 0) {
                    ForEach(0 ..< presentedReaction.count, id: \.self) { emoji in
                        let emoji = presentedReaction[emoji]
                        Button {
                            presentedReaction.removeAll(where: { $0 == emoji })
                        } label: {
                            Text(emoji.rawValue)
                        }
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    }
                }
                .padding(5)
                .background(Color.cyan)
                .opacity(presentedReaction.isEmpty ? 0 : 1)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.leading, 9)
                .padding(.trailing, 24)

            }

        }
        .onAppear {

        }

    }
}

struct OtherTextMsgView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            OtherTextMsgView()
            Spacer()
        }

    }
}

