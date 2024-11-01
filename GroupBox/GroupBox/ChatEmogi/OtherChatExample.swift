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
    @State var selectedReaction: Emoji?
    @State var presentedReaction: [Emoji] = [Emoji("\u{2764}")]

//    let namespace: Namespace.ID

    public init() {
    }

    public var body: some View {
        ChatOtherProfileView {
            VStack(alignment: .leading, spacing: 0) {
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
                    .background(Color.purple)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6))
                    .cornerRadius(radius, corners: [.topRight, .bottomLeft, .bottomRight])



                    ClockView(time: 1710311370)
                }
                .padding(.top, 4)
                .padding(.leading, 8)

                // SELECTED EMOJI
                Text(selectedReaction?.unicode ?? "\u{2764}")
                    .frame(height: 20)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Color(red: 0.945, green: 0.945, blue: 0.945))
//                    .opacity(presentedReaction.isEmpty ? 0 : 1)
                    .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.white, lineWidth: 4.0))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .padding(.leading, 16)
                    .padding(.top, -6)
                    .opacity((selectedReaction?.unicode ?? "\u{2764}").isEmpty ? 0 : 1)

            }

        }
        .overlay(alignment: .bottom) {
//            HStack(spacing: 5) {
//
//                ForEach(0 ..< EmojiReaction.allCases.count, id: \.self) { index in
//                    let emoji = EmojiReaction.allCases[index]
//                    Button {
//                        showEmoji = false
//                        selectedReaction = selectedReaction == emoji ? nil : emoji
//                        if presentedReaction.contains(where: { $0  == emoji}) {
//                            presentedReaction.removeAll(where: { $0 == emoji})
//                        } else {
//                            presentedReaction.append(emoji)
//                        }
//                    } label: {
//                        Text(emoji.rawValue)
//                    }
//                    .frame(width: 35, height: 35)
//                    .background(selectedReaction == emoji ? Color.gray.opacity(0.25) : Color.clear)
//                    .clipShape(Circle())
//                    .offset(y: showEmoji ? 0 : 40)
//                    .animation(.easeInOut.delay(0.05 * Double(index)), value: showEmoji)
//
//                }
//            }
//            .padding(5)
//            .background(.gray)
//            .clipShape(RoundedRectangle(cornerRadius: 25))
//            .opacity(showEmoji ? 1 : 0)
//            .animation(.easeIn, value: showEmoji)
        }
        .onAppear {

        }

    }
}

struct OtherTextMsgView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            OtherTextMsgView()
                .background(Color.blue)
            Spacer()
        }
        .background(Color(red: 0.882, green: 0.882, blue: 0.882))
    }
}

