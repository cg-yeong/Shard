//
//  KeyPadButton.swift
//  GroupBox
//
//  Created by root0 on 7/22/24.
//

import SwiftUI

extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}

struct KeyPadButton: View {
    @Environment(\.keyPadButtonAction) var action: (String) -> Void

    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }

    var key: String

    var body: some View {
        Button {
            action(key)
        } label: {
            Color.clear
                .overlay {
                    if key == "<" {
                        Image(systemName: "arrowshape.left.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .tint(.white)
                            .padding()
                    } else {
                        Text(key)
                            .font(.system(size: 22, weight: .bold))
                            .kerning(-1.1)
                            .foregroundStyle(Color.white)
                            .padding()
                    }
                }
        }
        .frame(width: 120, height: 64)
    }
}

struct KeyPadRow: View {
    var keys: [String]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(keys, id: \.self) { key in
                KeyPadButton(key: key)
            }
        }
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

#Preview {
    ZStack {
        Color.green
        FastPayPasswordAuth(errCnt: .constant(0))
    }
}
