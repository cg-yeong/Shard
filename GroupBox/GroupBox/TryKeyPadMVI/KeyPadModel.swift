//
//  KeyPadModel.swift
//  GroupBox
//
//  Created by root0 on 8/1/24.
//

import SwiftUI

enum KeyPadState {
    case didAppear
    case typing
    case error
}

protocol KeyPadStateProtocol {
    var keypadState: KeyPadState { get }
    var errorText: String { get }
    var errCnt: Int { get }
    var pin: [String] { get }
}

protocol KeyPadActionProtocol: AnyObject {
    func typing(number: String)
    func displayError(cnt: Int)
}

final class KeyPadModel: ObservableObject, KeyPadStateProtocol {
    @Published var pin: [String] = []
    @Published var keypadState: KeyPadState = .didAppear
    @Published var errCnt: Int = 0

    var errorText: String = ""

    var maxCountOfPin = 6
}

extension KeyPadModel: KeyPadActionProtocol {

    func typing(number: String) {
        pin.append(number)
    }

    func displayError(cnt: Int) {

    }

}


