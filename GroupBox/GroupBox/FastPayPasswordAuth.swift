//
//  FastPayPasswordAuth.swift
//  GroupBox
//
//  Created by root0 on 7/26/24.
//

import SwiftUI

struct KeyPadMatrix {
    var row1: [Int]
    var row2: [Int]
    var row3: [Int]
    var row4: [Int]
}

struct FastPayPasswordAuth: View {

    var randomPad: [Int] = [2, 1, 3, 6, 4, 7, 9, 8, 5]
    var successDirectJewelPay: ((String) -> Void)!
    var closeKeyPad: (() -> Void)!

    var maxDigit: Int = 6
    var padDigits: KeyPadMatrix!

    @State var pin: [String] = [] {
        didSet {
            print("new input pin : \(pin.map { $0 }) == \(pin.map { $0 })")
        }
    }

    @Binding var errCnt: Int
    @State var errorTitle: String = ""

    @State var isDisabled: Bool = false
    @State var isPopupPresented = false
    @State var payResultMessage = ""
    @State var shake: Bool = false

    init(errCnt: Binding<Int>) {

        if randomPad.count >= 10 {

            let row1 = Array(randomPad.prefix(3))
            randomPad.removeFirst(3)

            let row2 = Array(randomPad.prefix(3))
            randomPad.removeFirst(3)

            let row3 = Array(randomPad.prefix(3))
            randomPad.removeFirst(3)

            let row4 = [-2] + randomPad + [-1]

            padDigits = KeyPadMatrix(row1: row1, row2: row2, row3: row3, row4: row4)

        }
        self._errCnt = errCnt
    }

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 0) {
                    Text("결제비밀번호")
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            Image("closeRemove")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .padding(14)
                                .onTapGesture {
                                    closeKeyPad()
                                }
                            , alignment: .trailing
                        )

                    Spacer().frame(maxHeight: 51)

                    Text(errorTitle)
                        .font(.custom("fontName", size: 15))
                        .foregroundColor(
                            Color(red: 1, green: 51.0 / 255.0, blue: 75.0 / 255.0)
                        )
                        .kerning(-0.75)
                        .padding(.bottom, 24)
                        .opacity(errCnt > 0 ? 1 : 0)
                        .onChange(of: errCnt) { newValue in
                            if newValue < 10 {
                                errorTitle = "비밀번호가 일치하지 않아요(\(errCnt)/10)"
                            } else {
                                errorTitle = "비밀번호 10회 오류로 초기화가 필요해요"
                            }
                        }
                        .offset(x: shake ? 5 : 0)
                        .animation(.interactiveSpring(response: 0.2, dampingFraction: 0.08), value: shake)
                        .onChange(of: shake) { new in
                            guard new else { return }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                shake = false
                            }
                        }

                    HStack(spacing: 10) {
                        ForEach(0 ..< maxDigit, id: \.self) { index in
                            Image(systemName: getImage(at: index))
                        }
                    }
                    Spacer().frame(maxHeight: 56)

                    HStack(spacing: 0) {
                        Text("랜덤 키패드")
                            .font(.custom("fontName", size: 15))
                            .foregroundColor(Color(white: 148.0 / 255.0))
                            .kerning(-0.75)
                        Image("caretRightSm")
                        Text("비밀번호 설정")
                            .font(.custom("fontName", size: 15))
                            .foregroundColor(Color(white: 148.0 / 255.0))
                            .kerning(-0.75)
                    }
                    .padding(.bottom, 35)
                    .opacity(errCnt >= 10 && !errorTitle.isEmpty ? 1 : 0)

                    VStack(spacing: 0) {
                        Label(
                            title: { Text("보안키패드 작동중").foregroundColor(Color(white: 148.0 / 255.0)) },
                            icon: { Image("lock") }
                        )
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 25.0 / 255.0, green: 28.0 / 255.0, blue: 33.0 / 255.0))

                        Divider().background(Color(white: 85.0 / 255.0))

                        KeyPad
                            .background(Color(red: 25.0 / 255.0, green: 28.0 / 255.0, blue: 33.0 / 255.0))
                            //.disabled(isDisabled) // 애니 위해서 액션에서 막아주기
                    }
                    .background(Color(red: 25.0 / 255.0, green: 28.0 / 255.0, blue: 33.0 / 255.0))
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24.0))
            }
            .padding(.bottom, proxy.safeAreaInsets.bottom)
            .background(
                VStack {
                    Color.clear
                    Color(red: 25.0 / 255.0, green: 28.0 / 255.0, blue: 33.0 / 255.0).frame(height: 60)
                }
            )
            .ignoresSafeArea()
        }
    }


    @ViewBuilder
    var KeyPad: some View {
        VStack(spacing: 0) {
            KeyPadRow(keys: ["2", "5", "8"])
            KeyPadRow(keys: ["9", "1", "3"])
            KeyPadRow(keys: ["7", "0", "4"])
            KeyPadRow(keys: ["-2", "6", "<"])
        }
        .environment(\.keyPadButtonAction, self.keyWasPressed(_:))
        .background(Color(red: 25.0 / 255.0, green: 28.0 / 255.0, blue: 33.0 / 255.0))
    }

    func keyWasPressed(_ key: String) {
        guard errCnt <= 10 else {
            shake = true
            return
        }

        switch key {
        case "-2":
            pin.removeAll()
        case "<":
            if !pin.isEmpty {
                pin.removeLast()
            }
        default:
            if pin.count < maxDigit {
                pin.append(key)
            }
        }
        submitPin()
    }

    private func submitPin() {
        guard !pin.isEmpty else { return }

        if pin.count == maxDigit {
            isDisabled = true

            verifyPinInputs()
        }

        if pin.count > maxDigit {
            pin = Array(pin[pin.startIndex ..< maxDigit])
            submitPin()
        }
    }

    private func verifyPinInputs(justcheck : Bool = false) {
        guard pin.count == maxDigit else { return }

        print("비밀번호 입력 확인 : \(pin)")

        guard errCnt < 10 else {
            errorTitle = "비밀번호 10회 오류로 초기화가 필요해요"
            errCnt += 1
            return
        }

        Task { @MainActor in
            do {
                // api
                pin.removeAll()

                // api return success or fail

            }
            isDisabled = false
        }
    }

    private func getImage(at index: Int) -> String {
        if index >= pin.count {
            return "circle"
        }

        return "circle.fill"
    }
}

#Preview {
    ZStack {
        Color.green
        FastPayPasswordAuth(errCnt: .constant(0))
    }
}
